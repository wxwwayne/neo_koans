require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]
    assert_equal "dos", hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal "uno", hash.fetch(:one)
    ###hash[] is the same as hash.fetch() but hash.fetch() will return
    ###KeyError if key doesn't exist!!!
    assert_raise(KeyError) do #error class
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
    ###fetch(key_name, default_value): get the value if the key exists, 
    ###return default_value otherwise!!!
    ###But fetch will NOT chage the value of the original hash!!!
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "eins", :two => "dos" }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  def test_hash_is_unordered 
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }
    assert_equal true, hash1 == hash2
  end
  ###hash is unordered!!!

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size
    ###hash has the API keys and values but array does NOT!!!
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class 
    #hash keys are under class of ARRAY!!!
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?("uno")
    assert_equal true, hash.values.include?("dos")
    assert_equal Array, hash.values.class 
    #hash's keys and values are all Array class!!
    #array doesn't have values or keys!!!We cannot call like array.keys
    #or array.values but we can call hash.keys or hash.values!!!
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal true, hash != new_hash

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal true, expected == new_hash
    ###when we do hash.merge we will overrite the old value of the key 
    ###with the new one and create the new keys!!!
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("dos") 
    hash2[:one] = 1        
    ###to define the hash default value="dos" by default all
    ###hash values are "dos" unless you assign other value!!!

    assert_equal 1, hash2[:one]
    assert_equal "dos", hash2[:two]
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])
    ###this is a definition of a hash with default value of []!!!
    hash[:one] << "uno"
    hash[:two] << "dos"
    ###we shavel "uno" into the array which is the default value!!
    ###this is the default value for all keys!!!
    assert_equal ["uno", "dos"], hash[:one]
    assert_equal ["uno", "dos"], hash[:two]
    assert_equal ["uno", "dos"], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id
    ###When you're doing hash = Hash.new([]) you are creating a 
    ###Hash whose default value is the exact same Array instance 
    ###for all keys. So whenever you are accessing a key that 
    ###doesn't exist, you get back the very same Array.
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] }

    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal ["uno"], hash[:one]
    assert_equal ["dos"], hash[:two]
    assert_equal [], hash[:three]
  end
  ###in hash initilization ()--default value is nil, {}--blck, 
  ###([]) --default value is array!!!
end
