from functools import reduce
import random
import pandas as pd
import names
from faker import Faker

FAKE = Faker()


def gen_cities(n: int):
    r = range(1, n + 1)
    cityID = r
    city_name = list(map(lambda a: FAKE.city(), r))
    location = list(map(lambda a: FAKE.coordinate(), r))
    stateID = list(map(lambda a: random.randint(1, 501), r))
    coloms_name = ("cityID", "name", "location", "stateID")
    t_name = "city"

    data = ""
    for i in r:
        data += f"insert into {t_name} ({', '.join(coloms_name)}) values ({cityID[i-1]}, '{city_name[i-1]}', {str(location[i-1])}, {stateID[i-1]});\n"

    with open("gen_cities.sql", "w") as f:
        f.write(data)


gen_cities(4000)