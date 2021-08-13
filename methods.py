from models import UserHistory
def addHist(session, ip, title, code):
    value = UserHistory(id=ip, title=title, code=code)
    session.add(value)

def getHist(session, ip):
    values = session.query(UserHistory).filter(UserHistory.id == ip).all()
    return list(map(lambda value: {'title': value.title, 'code': value.code}, values))
