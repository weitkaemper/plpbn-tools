import bnlearn as bn
from python_util import bn_to_logtalk


DAG = bn.import_DAG("sprinkler")
bn_to_logtalk(DAG, object_name="bn_sprinkler_py", file="bn_sprinkler_py.lgt")
with open("bn_sprinkler_py.lgt") as f:
    print(f.read())
