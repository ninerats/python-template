"""
Basic test using pytest.
Learn more:
- https://docs.pytest.org/en/stable/
- https://realpython.com/pytest-python-testing/
"""

def add(a, b):
    return a + b

def test_add():
    assert add(2, 3) == 5
