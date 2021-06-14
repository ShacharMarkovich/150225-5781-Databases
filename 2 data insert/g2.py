import random

from faker import Faker

FAKE = Faker()


# gen all seats in all planes
def genSeats():
    """gen all seats in all planes

    Args:
        n (int): numers in row in db
        plane_count (int): number of planes in DB
    """
    with open("gen_planes.sql", "r") as planes:
        f = open("gen_PlaneSeat2.sql", "w")
        # asuming each plane has 7 seats in a row:
        COLS = 7
        seatID = 1
        data = ""
        cs = ["T"] * 5 + ["B"] * 3 + ["F"]
        lr8 = [*list(range(1, 8))]
        win = [*([1] + [0] * (COLS - 2) + [1])]
        mid = [*([0] * 2 + [1] * (COLS - 4) + [0] * 2)]
        coloms_name = (
                "seatID",
                "class",
                "the_row",
                "col",
                "isWithWindow",
                "IsInMiddleRow",
                "PlaneID",
            )
        t_name = "PlaneSeat"
        head = f"insert into {t_name} ({', '.join(coloms_name)}) values ("
        
        for plane in planes.read().split("\n"):
            # each line look like:
            # insert into Plane (planeID, type, model, p_size, currWeight, maxWeight) values (1, 'P', 'anthony27', 496, 496, 496);
            plane_i_data = plane.split(") values (")[1].split(",")
            planeID = int(plane_i_data[0])
            pi_size = int(plane_i_data[3])

            rows_num = pi_size // 7
            _class = [random.choice(cs) for _ in range(pi_size)]

            the_row = []
            for ri in range(rows_num):
                the_row += [*[ri] * COLS]

            col = lr8 * rows_num
            isWithWindow =  win * rows_num

            IsInMiddleRow = mid * rows_num

            PlaneID = [*[planeID] * COLS * rows_num]
            

            for i in range(COLS * rows_num):  # write to file
                data = f"{head}{seatID}, '{_class[i]}', {the_row[i]}, {col[i]}, {isWithWindow[i]}, {IsInMiddleRow[i]}, {PlaneID[i]});\n"
                f.write(data)
                if seatID % 10000 == 0:
                    print(seatID)
                    print(data)
                seatID += 1
        
        f.close()


if __name__ == "__main__":
    genSeats()
