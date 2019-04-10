# fixtopt

Extend your pytests with options that can be accessed as test fixtures.

Add the options like this:

```python
from fixtopt import Option, register

def pytest_options(parser):
    register(globals(), parser, (

        Option(
            name="message",
            default="message.txt",
            help="the message file"),

        Option(
            name="receiver",
            default="World",
            help="the receiver"),

    ))
```

Import the options in your tests like you would import a fixture:

```python
import my_mailclient

def test_a_person_receives_a_message(message, receiver):
    with open(message) as f:
        assert my_mailclient.receiver(f.read()) == receiver
```

And you can run your tests with the declared options:

```shell
pytest . --message /path/to/messagefile --receiver mrs.X
```