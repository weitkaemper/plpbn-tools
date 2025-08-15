import bnlearn as bn
from pathlib import Path

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
            state_names = cpd.state_names[node]

            if not parents:
                # Root node: single vector of probabilities
                for state, prob in zip(state_names, cpd.get_values()):
                    f.write(f"cpt({node.lower()},[],{float(prob)}).\n")
            else:
                # Parents exist: multi-dimensional table
                evidence_states = [cpd.state_names[p] for p in parents]
                num_parent_states = [len(s) for s in evidence_states]

                # Flatten the CPT to iterate over parent combos
                values = cpd.get_values().reshape(-1, len(state_names))
                for row_idx, probs in enumerate(values):
                    # Decode parent assignments from row index
                    assignments = []
                    idx = row_idx
                    for p, vals in zip(parents, evidence_states):
                        val = str(bool(vals[idx % len(vals)]))
                        assignments.append(f"{p.lower()}-{val.lower()}")
                        idx //= len(vals)
                    assignments_str = ",".join(assignments)
                    for state, prob in zip(state_names, probs):
                        f.write(f"cpt({node.lower()},[{assignments_str}],{float(prob)}).\n")

        f.write("\n:- end_object.\n")
