class Student < ApplicationRecord
  before_create :data_encrypt

  # 512bit key
  KEY = 8327111146272291426983943786406771087426117365534801452642159711197277282986365931764943874729708091177902142948066985065903829727042427582978125348137384
  BIT_LENGTH = 16

  ############ 本来はこの関数はあってはならないので ##############
  def decrypt_result
    cipher = ::MyCipher.new(BIT_LENGTH, KEY, KEY)
    cipher.decrypt(cipher_string_to_array(self.result))
  end

  def decrypt_parent_income
    cipher = ::MyCipher.new(BIT_LENGTH, KEY, KEY)
    cipher.decrypt(cipher_string_to_array(self.parent_income))
  end

  def decrypt_mother_existance
    cipher = ::MyCipher.new(BIT_LENGTH, KEY, KEY)
    cipher.decrypt(cipher_string_to_array(self.mother_existance))
  end
  ##################################################################

  def data_encrypt
    cipher = ::MyCipher.new(BIT_LENGTH, KEY, KEY)
    self.result = cipher_array_to_string(cipher.encrypt(self.result.to_i))
    self.parent_income = cipher_array_to_string(cipher.encrypt(self.parent_income.to_i))
    self.mother_existance = cipher_array_to_string(cipher.encrypt(self.mother_existance.to_i))
  end

  def cipher_array_to_string(cipher)
    str = ""
    cipher.map{ |c| str << "#{c}," }
    str.chop
  end

  def cipher_string_to_array(string)
    string.split(',').map{ |s| s = s.to_i }
  end
end
