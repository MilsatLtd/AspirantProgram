from enum import Enum


class GENDER(Enum):
    MALE = 0
    FEMALE = 1


class ROLE(Enum):
    ADMIN = 0
    MENTOR = 1
    STUDENT = 2


class EDUCATION(Enum):
    HIGH_SCHOOL = 0
    UNDERGRADUATE = 1
    GRADUATE = 2


class APPLICATION_STATUS(Enum):
    PENDING = 0
    ACCEPTED = 1
    REJECTED = 2


class COHORT_STATUS(Enum):
    ACTIVE = 0
    INACTIVE = 1
    UPCOMING = 2
    ENDED = 3


class TODO_FEEDBACK(Enum):
    FAILED = 0
    PASSED = 1


class TODO_STATUS(Enum):
    PENDING = 0
    REVIEWED = 1
