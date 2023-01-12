from __future__ import annotations
from typing import Any, List

def find_in_structural_lists(data: List[Any], element_to_find: Any) -> List[int]:
    """
    Funkcja poszukuje wskazany element w zbiorze strukturalnym list 
        (iterowalnym na wielu poziomach, np. [[1, 2, [3]], 4, 5]).
    Zwraca kolejne indeksy elementów, w których znajduje się szukany element.
    W przypadku braku elementu, zwraca pustą listę.
    """
    trace_index: List[int] = []
    trace_data: List[List[Any]] = []
    curr_data: List[Any] = data
    curr_index: int = 0

    while True:
        if curr_index >= len(curr_data):
            # reached end of current list
            if len(trace_index) == 0:
                # reached end of everything, not found
                return []
            # get previous data as current
            curr_data = trace_data.pop()
            # get previous index as current, go to next index
            curr_index = trace_index.pop() + 1
            continue

        el = curr_data[curr_index]
        # there is an element to check
        if isinstance(el, list):
            # add list and index to trace
            trace_index.append(curr_index)
            trace_data.append(curr_data)
            # change current data to nested one
            curr_data = curr_data[curr_index]
            # reset current index to zero
            curr_index = 0
            continue
        else:
            # check if this element is the one searched
            if el == element_to_find:
                # found! add current index to trace and return
                trace_index.append(curr_index)
                return trace_index
            else:
                # not the one, increment index
                curr_index += 1