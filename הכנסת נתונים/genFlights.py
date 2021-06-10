# flight
MAX_PLANE_ID = 500
from random import randint, choice
from datetime import datetime, timedelta

flight_sql_file = open("gen_flightdata.sql", "w+")
SIZE = 20000
PLAIN_COUNT = 4000


def main():
    for id in range(1, SIZE):
        flight_date = datetime.now() + timedelta(
            days=randint(-50, 100), hours=randint(-100, 100)
        )
        flight_date = flight_date.replace(
            second=0, minute=choice([0, 15, 30, 45, 0, 30, 0, 30, 0])
        )
        flight_time = randint(30, 1050)
        # take only 2021-06-29 11:00 from 2021-06-29 11:00:00.977900
        flight_date = str(flight_date)[:-10].replace("-", "/")
        plane_id = randint(1, MAX_PLANE_ID)
        src_airport_id = randint(1, PLAIN_COUNT)
        dst_airport_id = src_airport_id
        while dst_airport_id == src_airport_id:
            dst_airport_id = randint(1, PLAIN_COUNT)
        to_print = f"INSERT INTO FLIGHT(flightid, takeoffdatetime, flighttime, planeid, srcairportid, dstairportid) values ({id},to_date('{flight_date}', 'YYYY/MM/DD HH24:MI'),{flight_time},{plane_id},{src_airport_id},{dst_airport_id});\n"
        flight_sql_file.write(to_print)


if __name__ == "__main__":
    main()