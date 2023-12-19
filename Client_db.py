import psycopg2


def create_db(conn):
    with conn.cursor() as cur:
        cur.execute("CREATE TABLE IF NOT EXISTS clients("
                    "client_id SERIAL PRIMARY KEY, "
                    "first_name VARCHAR(30), "
                    "last_name VARCHAR(30), "
                    "email VARCHAR(40) UNIQUE);")
        cur.execute("CREATE TABLE IF NOT EXISTS phones("
                    "phones_id SERIAL PRIMARY KEY, "
                    "phone_number DECIMAL(10,0) UNIQUE, "
                    "client_id INT NOT NULL REFERENCES clients(client_id));")
        conn.commit()


def add_client(conn, first_name, last_name, email, phones=None):
    with conn.cursor() as cur:
        cur.execute(f"INSERT INTO clients(first_name, last_name, email) "
                    f"VALUES ('{first_name}', '{last_name}', '{email}');")
        conn.commit()
    if phones != None:
        with conn.cursor() as cur:
            cur.execute("SELECT MAX(client_id) FROM clients;")
            client_id_current = (cur.fetchall()[0][0])
            for phone in phones.split(", "):
                cur.execute(f"INSERT INTO phones(phone_number, client_id) "
                            f"VALUES ('{phone}', '{client_id_current}');")
            conn.commit()


def add_phone(conn, client_id, phone):
    with conn.cursor() as cur:
        cur.execute(f"INSERT INTO phones(phone_number, client_id) VALUES ('{phone}', '{client_id}');")
        conn.commit()


def change_client(conn, client_id, first_name=None, last_name=None, email=None, phones=None):
    with conn.cursor() as cur:
        if first_name != None:
            cur.execute(f"UPDATE clients SET first_name = '{first_name}' WHERE client_id = '{client_id}';")
        if last_name != None:
            cur.execute(
                f"UPDATE clients SET last_name = '{last_name}' WHERE client_id = '{client_id}';")
        if email != None:
            cur.execute(
                f"UPDATE clients SET email = '{email}' WHERE client_id = '{client_id}';")
        if phones != None:
            cur.execute(f"DELETE FROM phones WHERE client_id = '{client_id}';")
            for phone in phones.split(", "):
                cur.execute(f"INSERT INTO phones(phone_number, client_id) VALUES ('{phone}', '{client_id}');")
        conn.commit()


def delete_phone(conn, client_id, phone):
    with conn.cursor() as cur:
        cur.execute(f"DELETE FROM phones WHERE phone_number = '{phone}' and client_id = '{client_id}';")
        conn.commit()


def delete_client(conn, client_id):
    with conn.cursor() as cur:
        cur.execute(f"DELETE FROM phones WHERE client_id = '{client_id}';")
        cur.execute(f"DELETE FROM clients WHERE client_id = '{client_id}';")
        conn.commit()


def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
    if first_name == None:
        first_name_str = True
    else:
        first_name_str = f"c.first_name ILIKE '{first_name}'"
    if last_name == None:
        last_name_str = True
    else:
        last_name_str = f"c.last_name ILIKE '{last_name}'"
    if email == None:
        email_str = True
    else:
        email_str = f"c.email ILIKE '{email}'"
    if phone == None:
        phone_str = True
    else:
        phone_str = f"p.phone_number ILIKE '{phone}'"
    with conn.cursor() as cur:
        cur.execute(f"SELECT DISTINCT c.client_id "
                    f"FROM clients c "
                    f"FULL OUTER JOIN phones p on c.client_id = p.client_id "
                    f"WHERE {first_name_str} AND  {last_name_str} AND {email_str} AND {phone_str};")
        result = cur.fetchall()[0][0]
    return result


with psycopg2.connect(database="clients_db", user="postgres", password="postgres") as conn:
    create_db(conn)
    # add_client(conn, 'Sergey',  'Gavrikov', '5519609@mail.ru', '4997632118, 100, 9645519609')
    # add_client(conn, 'Alexey', 'Glazunov', '3342211@mail.ru')
    # add_client(conn, 'Maria', 'Gromova', '445@yandex.ru')
    # client_id_1 = find_client(conn, first_name='Sergey', last_name='gavrikov')
    # client_id_2 = find_client(conn, email = '3342211@mail.ru')
    # client_id_3 = find_client(conn, first_name='maria')
    # add_phone(conn, client_id_2, '9037777777')
    # add_phone(conn, client_id_3, '555')
    # add_phone(conn, client_id_3, '9164901523')
    # change_client(conn, client_id_3, phones='333444, 9161561377, 4997751663')
    # delete_phone(conn, client_id_3, '333444')
    # delete_client(conn, client_id_2)
