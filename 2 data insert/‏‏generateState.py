from functools import reduce
import random
import pandas as pd
import names
from faker import Faker

FAKE = Faker()


def gen_states(n: int):
    r = range(1, n + 1)
    stateID = r
    city_name = list(map(lambda a: FAKE.city(), r))
    coloms_name = ("stateID", "name")
    t_name = "state"

    data = ""
    for i in r:
        data += f"insert into {t_name} ({', '.join(coloms_name)}) values ({stateID[i-1]}, '{city_name[i-1]}');\n"

    with open("gen_states.sql", "w") as f:
        f.write(data)


gen_states(500)