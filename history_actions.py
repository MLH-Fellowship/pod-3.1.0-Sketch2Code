from methods import addHist, getHist
from cockroachdb.sqlalchemy import run_transaction
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
class HistoryActions:
    def __init__(self, conn_string):
        self.engine = create_engine(conn_string, convert_unicode=True)
        self.sessionmaker = sessionmaker(bind=self.engine)
    def addHistory(self, ip, title, code):
        return run_transaction(self.sessionmaker,
                               lambda session: addHist(session, ip, title, code))
    def getHistory(self, ip):
        return run_transaction(self.sessionmaker,
                               lambda session: getHist(session, ip))
