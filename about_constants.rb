require File.expand_path(File.dirname(__FILE__) + '/neo')

C = "top level"

class AboutConstants < Neo::Koan

  C = "nested"

  def test_nested_constants_may_also_be_referenced_with_relative_paths
    assert_equal "nested", C
  end

  def test_top_level_constants_are_referenced_by_double_colons
    assert_equal "top level", ::C
  end

  def test_nested_constants_are_referenced_by_their_complete_path
    assert_equal "nested", AboutConstants::C
    assert_equal "nested", ::AboutConstants::C
  end
 ##we are in a portion of code we can just access the local constant by calling it.
 ##If we want to hit the top level, we can do so with double colons, 
 ##and we can name the class by using the path to the class we are referring to.
  # ------------------------------------------------------------------

  class Animal
    LEGS = 4
    def legs_in_animal
      LEGS
    end

    class NestedAnimal
      def legs_in_nested_animal
        LEGS
      end
    end
  end

  def test_nested_classes_inherit_constants_from_enclosing_classes
    assert_equal 4, Animal::NestedAnimal.new.legs_in_nested_animal
  end
  ##we've never defined LEGS in NestedAnimal, but we have in Animal.
  ## Because NestedAnimal is in Animal, it automatically gets LEGS

  # ------------------------------------------------------------------

  class Reptile < Animal 
  #inherit methods and constants from Animal
    def legs_in_reptile
      LEGS
    end
  end

  def test_subclasses_inherit_constants_from_parent_classes
    assert_equal 4, Reptile.new.legs_in_reptile
  end

  # ------------------------------------------------------------------

  class MyAnimals
    LEGS = 2

    class Monkey < Animal
      def legs_in_monkey
        LEGS # => 2
      end
    end

    class Bird < Animal
      def legs_in_bird
        LEGS
      end
    end
  end

  def test_who_wins_with_both_nested_and_inherited_constants
    assert_equal 2, MyAnimals::Bird.new.legs_in_bird
    assert_equal 2, MyAnimals::Monkey.new.legs_in_monkey
  end

  # QUESTION: Which has precedence: The constant in the lexical scope,
  # or the constant from the inheritance hierarchy?
  ###when you define Bird, you are already in the scope of MyAnimals!
  # ------------------------------------------------------------------

  class MyAnimals::Oyster < Animal
    def legs_in_oyster
      LEGS
    end
  end

  def test_who_wins_with_explicit_scoping_on_class_definition
    assert_equal 4, MyAnimals::Oyster.new.legs_in_oyster
  end

  # QUESTION: Now which has precedence: The constant in the lexical
  # scope, or the constant from the inheritance hierarchy?  Why is it
  # different than the previous answer?
###When you define MyAnimals::Oyster you are still in the global scope, 
###so ruby has no knowledge of the LEGS value set to 2 in MyAnimals 
###because you never actually are in the scope of MyAnimals
end
