import bnlearn as bn
import numpy as np
from pathlib import Path


def normalize_state(s):
    """
    Normalize state labels: map '1' -> 'true', '0' -> 'false',
    otherwise lowercase the string.
    """
    if isinstance(s, (int, np.integer)):
        return "true" if s == 1 else "false"
    s = str(s).lower()
    if s in {"1", "true", "yes"}:
        return "true"
    elif s in {"0", "false", "no"}:
        return "false"
    return s


def bn_to_logtalk(model, object_name="bn_from_py", file="bn.lgt"):
    """
    Export a bnlearn model to a Logtalk object implementing the bnp protocol.

    Parameters
    ----------
    model : dict
        bnlearn model dict (model['model'] is a pgmpy BayesianModel,
        model['model'].cpds holds CPTs)
    object_name : str
        Name of the Logtalk object to create
    file : str or Path
        Output file path
    """
    file = Path(file)
    with file.open("w") as f:
        f.write(f":- object({object_name}, implements(bnp)).\n\n")

        # Nodes
        for n in model['model'].nodes:
            f.write(f"node({n.lower()}).\n")
        f.write("\n")

        # Edges
        for (src, dst) in model['model'].edges:
            f.write(f"edge({src.lower()},{dst.lower()}).\n")
        f.write("\n")

        # CPTs
        for cpd in model['model'].cpds:
            node = cpd.variable
            parents = list(cpd.get_evidence())
            state_names = [normalize_state(s) for s in cpd.state_names[node]]
            if "true" not in state_names or "false" not in state_names:
                raise ValueError(
                    f"Node {node} must have 'true'/'false' states, got {state_names}"
                )

            true_index = state_names.index("true")

            if not parents:
                # Root node
                values = np.array(cpd.get_values()).flatten()
                prob_true = float(values[true_index])
                f.write(f"cpt({node.lower()},[],{prob_true}).\n")
            else:
                # With parents
                evidence_states = [cpd.state_names[p] for p in parents]

                values = cpd.get_values().reshape(-1, len(state_names))
                for row_idx, probs in enumerate(values):
                    # Decode parent assignments from row index
                    assignments = []
                    idx = row_idx
                    for p, vals in zip(parents, evidence_states):
                        vals = [normalize_state(v) for v in vals]
                        val = vals[idx % len(vals)]
                        assignments.append(f"{p.lower()}-{val}")
                        idx //= len(vals)

                    assignments_str = ",".join(assignments)
                    prob_true = float(probs[true_index])
                    f.write(f"cpt({node.lower()},[{assignments_str}],{prob_true}).\n")

        f.write("\n:- end_object.\n")


if __name__ == "__main__":
    # Example with the sprinkler network
    DAG = bn.import_DAG("sprinkler")
    bn_to_logtalk(DAG, object_name="bn_sprinkler_py", file="bn_sprinkler_py.lgt")

    with open("bn_sprinkler_py.lgt") as f:
        print(f.read())
