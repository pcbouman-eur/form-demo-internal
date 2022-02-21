# A list of all courses in this example
my $courses = [ 'FEB11013X', 'FEB22012' ];

# A list of all years in this example
my $years = [ 2020, 2021 ];

# A list of the workflows in this example
my $workflows = ['assessment', 'course'];

# JSON Schema based data specification for a course. This is used by JSON forms to determine the structure of the form.
my $course_spec = {
	'type' => 'object',
        'properties' => {
		'coursecode' => {
			'type' => 'string',
                         'description' => 'Course code',
		},
		'name' => {
			'type' => 'string',
			'description' => 'Course name',
			'maxLength' => 128,
		},
		'description' => {
			'type' => 'string',
			'description' => 'Course description',
			'maxLength' => 4000
		}
         },
	'required' => ['coursecode', 'name', 'description']		
};

# JSON Schema based data specification for an assessment. This uses some more advanced data types, such as an array of objects
my $assessment_spec = {
	'type' => 'object',
	'properties' => {
		'attendance' => {
			'type' => 'boolean'
		},
		'assessments' => {
			'type' => 'array',
			'items' => {
				'type' => 'object',
				'properties' => {
					'name' => {
						'type' => 'string'
					},
					'kind' => {
						'type' => 'string',
						'enum' => ['exam','oral','assignment','presentation','report']	
					},
					'weight' => {
						'type' => 'number',
						'minimum' => 0
					}
				}
			}
		}
	}
};

# A hash that can provide the schema specification of both the courses
my $specs = {'assessment' => $assessment_spec, 'course' => $course_spec};

# A hash with actual data. In an actual application, this should come from a database
my $data = {
	'FEB11013X' => {
		'course' => {
			'2020' => {
				'coursecode' => 'FEB11013X',
				'name' => 'ICT (IBEB)',
				'description' => 'Something with Excel'
			},
			'2021' => {
				'coursecode' => 'FEB11013X',
				'name' => 'Introduction to Data-analytics',
				'description' => 'Something with Excel'
			}
		},
		'assessment' => {
			'2020' => {
				'attendance' => \1,
				'assessments' => [
					{'name' => 'midterm1', 'kind' => 'exam', 'weight' => 0.4},
					{'name' => 'midterm2', 'kind' => 'exam', 'weight' => 0.6}
				]	
			},
			'2021' => {
				'attendance' => \1,
				'assessments' => [
					{'name' => 'midterm1', 'kind' => 'exam', 'weight' => 0.4},
					{'name' => 'midterm2', 'kind' => 'exam', 'weight' => 0.6}
				]
			}
		}
	},
	'FEB22012' => {
		'course' => {
			'2020' => {
				'coursecode' => 'FEB22012',
				'name' => 'Programmeren',
				'description' => 'Java programmeren met objecten'
			},
			'2021' => {
				'coursecode' => 'FEB22012',
				'name' => 'Programmeren',
				'description' => 'Java programmeren met objecten'
			}
		},
		'assessment' => {
			'2020' => {
				'attendance' => \0,
				'assessments' => [
					{'name' => 'Assignment 1', 'kind' => 'assignment', 'weight' => 0.2},
					{'name' => 'Assignment 2', 'kind' => 'assignment', 'weight' => 0.2},
					{'name' => 'Assignment 3', 'kind' => 'assignment', 'weight' => 0.2},
					{'name' => 'Final Exam', 'kind' => 'exam', 'weight' => 0.4},
				]
			},
			'2021' => {
				'attendance' => \0,
				'assessments' => [
					{'name' => 'Assignment 1', 'kind' => 'assignment', 'weight' => 0.2},
					{'name' => 'Assignment 2', 'kind' => 'assignment', 'weight' => 0.2},
					{'name' => 'Assignment 3', 'kind' => 'assignment', 'weight' => 0.2},
					{'name' => 'Final Exam', 'kind' => 'exam', 'weight' => 0.4},
				]
			}
		}
	}
};

# A method that just provides a hash with all the data in this example
sub get_data() {
  return {
     'specs' => $specs,
     'data' => $data,
     'courses' => $courses,
     'years' => $years,
     'workflows' => $workflows
  };
}

1;
