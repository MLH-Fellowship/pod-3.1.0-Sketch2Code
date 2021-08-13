from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String
Base = declarative_base()

class UserHistory(Base):
    """
    Represents rows of the user_history table.

    Arguments:
        Base {DeclaritiveMeta} -- Base class for declarative SQLAlchemy class definitions that produces appropriate `sqlalchemy.schema.Table` objects.

    Returns:
        UserHistory -- Instance of the UserHistory class.
    """
    __tablename__ = 'user_history'
    id = Column(String, primary_key=True)
    title = Column(String)
    code = Column(String)

    def __repr__(self):
        return "<UserHistory(title='{0}', code='{1}')>".format(self.title, self.code)
