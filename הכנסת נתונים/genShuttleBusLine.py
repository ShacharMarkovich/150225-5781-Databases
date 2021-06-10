import datetime
import random
import time

from faker import Faker

FAKE = Faker()


def times(_):
    flag = True
    while flag:
        fake_start_time = FAKE.time()[:-3]
        t = time.strptime(fake_start_time, "%H:%M")
        hour = t.tm_hour
        minute = t.tm_min
        start = datetime.datetime(2000, 1, 1, hour=hour, minute=minute)
        try:  # in case that end date is before start date
            hour = random.randint(1, 23 - hour)
            minute = random.randint(1, 59)
            end = start + datetime.timedelta(hours=hour, minutes=minute)
            flag = False
        except:
            pass
    # take only HH:MM from datetime object in format YYYY-MM-DD HH:MI:SS
    return str(start).split()[1][:-3], str(end).split()[1][:-3]


def genSuttle(n: int):
    r = range(1, n + 1)
    shuttleID = r
    busCount = list(map(lambda a: random.randint(1, 60), r))
    startTime, endTime = list(zip(*map(times, r)))
    description = list(map(lambda a: FAKE.text().replace("\n", " "), r))

    srcAirportID = list(map(lambda a: random.randint(1, n), r))
    dstCityID = list(map(lambda a: random.randint(1, n), r))
    coloms_name = ("shuttleID", "busCount", "startTime", "endTime", "description", "dstCityID", "srcAirportID")
    t_name = "ShuttleBusLine"

    data = ""
    for i in r:
        data += (
            f"insert into {t_name} ({', '.join(coloms_name)}) values "
            + f"({shuttleID[i - 1]}, '{busCount[i - 1]}', to_date('{startTime[i - 1]}','HH24:MI'), to_date('{endTime[i - 1]}','HH24:MI'), '{description[i - 1]}', {srcAirportID[i - 1]}, {dstCityID[i - 1]});\n"
        )

    with open("gen_Suttle.sql", "w") as f:
        f.write(data)


genSuttle(4000)
