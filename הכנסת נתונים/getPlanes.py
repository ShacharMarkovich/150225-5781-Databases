import datetime
import random
import time

from faker import Faker

FAKE = Faker()


def genPlanes(n: int):
    r = range(1, n + 1)

    planeID = r

    types = ["P"] * 50 + ["C"] * 3
    types = [random.choice(types) for _ in r]

    model = [FAKE.user_name() for _ in r]
    p_size, currWeight, maxWeight = [], [], []
    for _ in r:
        s = random.randint(20, 900)
        p_size.append(s)
        # 40 is max luggage weight
        currWeight.append(round(random.uniform(0, s * 40), 2))
        maxWeight.append(s * 40)

    coloms_name = ("planeID", "type", "model", "p_size", "currWeight", "maxWeight")
    t_name = "Plane"

    data = ""
    for i in r:
        data += f"insert into {t_name} ({', '.join(coloms_name)}) values ({planeID[i - 1]}, '{types[i - 1]}', '{model[i - 1]}', {p_size[i - 1]}, {currWeight[i - 1]}, {maxWeight[i - 1]});\n"

    with open("gen_planes.sql", "w") as f:
        f.write(data)


genPlanes(400)
