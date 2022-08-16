import os
import unittest

from discopop_validation.source_code_modifications.CodeDifferences import file_difference_checker


class TestSourceCodeModifications(unittest.TestCase):
    def test_add_line_prior(self):
        path = os.path.dirname(os.path.abspath(__file__))
        print("PATH: ", path)
        dir_name = "add_line_prior"
        original_file = path + "/" + dir_name + "/original.c"
        modified_file = path + "/" + dir_name + "/modified.c"
        line_mapping, profiling_required = file_difference_checker(original_file, modified_file)
        expected_line_mapping = {
            1: 2
        }
        self.assertEqual(line_mapping, expected_line_mapping)
        self.assertTrue(profiling_required)