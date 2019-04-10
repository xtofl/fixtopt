"""template test file for testing the mop pytest options as fixture"""


def test_option_1_is_present(option1):
    """this test should fail depending on command line argument"""
    assert option1 == "user_provided"
