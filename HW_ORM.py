import sqlalchemy as sq
import json
from sqlalchemy.orm import declarative_base, relationship, sessionmaker
Base = declarative_base()


class Publisher(Base):
    __tablename__ = "publisher"

    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=40), unique=True)


class Book(Base):
    __tablename__ = "book"

    id = sq.Column(sq.Integer, primary_key=True)
    title = sq.Column(sq.String(length=40), unique=True)
    id_publisher = sq.Column(sq.Integer, sq.ForeignKey("publisher.id"), nullable=False)
    publisher = relationship(Publisher, backref="books")


class Shop(Base):
    __tablename__ = "shop"

    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=40), unique=True)


class Stock(Base):
    __tablename__ = "stock"

    id = sq.Column(sq.Integer, primary_key=True)
    id_book = sq.Column(sq.Integer, sq.ForeignKey("book.id"), nullable=False)
    id_shop = sq.Column(sq.Integer, sq.ForeignKey("shop.id"), nullable=False)
    count = sq.Column(sq.Integer)
    book = relationship(Book, backref="stock")
    shop = relationship(Shop, backref="stock")


class Sale(Base):
    __tablename__ = "sale"

    id = sq.Column(sq.Integer, primary_key=True)
    price = sq.Column(sq.DECIMAL(5, 2))
    date_sale = sq.Column(sq.Date)
    id_stock = sq.Column(sq.Integer, sq.ForeignKey("stock.id"), nullable=False)
    count = sq.Column(sq.Integer)
    stock = relationship(Stock, backref="sale")


def create_tables(engine):
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)


login = 'postgres'
password = 'postgres'
bd_name = 'book_db'
DSN = f"postgresql://{login}:{password}@localhost:5432/{bd_name}"
engine = sq.create_engine(DSN)
create_tables(engine)
Session = sessionmaker(bind=engine)
session = Session()


#Заполнение БД из файла(Задание 3)

with open('tests_data.json') as f:
    data = json.load(f)
for record in data:
    model = {'publisher': Publisher, 'shop': Shop, 'book': Book, 'stock': Stock, 'sale': Sale}[record['model']]
    session.add(model(id=record['pk'], **record['fields']))
session.commit()

#Задание 2

def get_shops(pub_name): #Функция принимает обязательный параметр
    Session = sessionmaker(bind=engine)
    dbsession = Session()
    q = dbsession.query(Book.title, Shop.name, Sale.price, Sale.date_sale).select_from(Shop). \
        join(Stock).join(Book).join(Publisher).join(Sale)
    if pub_name_id.isdigit():
        result = q.filter(Publisher.id == pub_name_id).all()
    else:
        result = q.filter(Publisher.name == pub_name_id).all()
    print(f"{'Название книги': <40} | {'Название магазина': <20} | {'Стоимость': <12} | {'Дата покупки'}")
    for book, shop, price, date in result:
        print(f"{book: <40} | {shop: <20} | {price: <12} | {date.strftime('%d-%m-%Y')}")

if __name__ == '__main__':
    pub_name_id = input("Введите имя или ID издателя: ")
    get_shops(pub_name_id)