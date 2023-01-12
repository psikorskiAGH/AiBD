from __future__ import annotations
from typing import Any, List
import pytest
import app_file

testdata_find_in_structural_lists = [
    # Przypadki typowe
    ([[1, 2, [3]], 4, 5], 2, [0, 1]),
    (['ala', "ma", "koty", ":", ["raz", "dwa", "trzy"]], "raz", [4, 0]),
    ([1, [2, [3, [4], 5], 6], 7], 4, [1, 1, 1, 0]),
    # Przypadki szczególne
    ([], 'no', []),
    ([1, 2, 3], 4, []),
    ([[[[[[[[[[0]]]]]]]]]], 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]),
]

@pytest.mark.parametrize(
    'data, element_to_find, answer', 
    testdata_find_in_structural_lists
)
def test_find_in_structural_lists(
        data: List[Any], 
        element_to_find: Any, 
        answer: List[int]
    ):
    result = app_file.find_in_structural_lists(data, element_to_find)
    assert result == answer
