from functools import reduce
import random
import pandas as pd
import names
from faker import Faker

FAKE = Faker()

def gen_airports(n: int):
    r = range(1, n + 1)
    airportID = r
    name = list(map(lambda a: FAKE.last_name(), r))
    abbreviation = list(map(lambda a: "".join(FAKE.random_letters()[:4]), r))
    cityID = list(map(lambda a: random.randint(1, n), r))
    coloms_name = ("airportID", "fullName", "abbreviation", "cityID")
    t_name = "airport"

    data = ""
    for i in r:
        data += f"insert into {t_name} ({', '.join(coloms_name)}) values ({airportID[i-1]}, '{name[i-1]}', '{abbreviation[i-1]}', {cityID[i-1]});\n"

    with open("gen_airports.sql", "w") as f:
        f.write(data)


gen_airports(4000)