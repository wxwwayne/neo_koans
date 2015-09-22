require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal ["John","Smith"], names###class Array
  end

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"] 
    # define couple vars with array
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal ["Smith","III"], last_name 
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]
    ###strings also work e.g. first_name, last_name = "Cher", "www" 
    assert_equal "Cher", first_name
    assert_equal nil, last_name 
    #more vars than array elements, rest be nil 
  end

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal ["Willie", "Rae"], first_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"]
    assert_equal "John", first_name 
    #more elements than vars, only take one
  end

  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    ###we can swap directly!!no need of a TEMP any more!!
    assert_equal "Rob", first_name
    assert_equal "Roy", last_name
  end
end
