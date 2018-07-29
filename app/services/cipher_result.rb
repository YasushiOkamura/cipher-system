class CipherResult
  def initialize
  end

  def execute
    key = 8327111146272291426983943786406771087426117365534801452642159711197277282986365931764943874729708091177902142948066985065903829727042427582978125348137384
    bit_length = 16
    cipher = MyCipher.new(bit_length, key, key)
    
    c_result_sum = cipher.encrypt(0)
    c_number_sum = cipher.encrypt(0)

    # とりあえず母親がいる人の平均を計算する
    Student.all.each do |student|
      # 母親がいるかいないかの暗号を文字列から配列に
      c_mother_existance = student.cipher_string_to_array(student.mother_existance)
      c_result = student.cipher_string_to_array(student.result)
      # 0,1を all 0,1 にマッピング
      c_all = Array.new(bit_length).map{ |c| c = c_mother_existance[bit_length - 1] }
      # 
      c_result_sum = cipher.c_add(c_result_sum, cipher.c_and(c_result, c_all))
      c_number_sum = cipher.c_add(c_number_sum, c_mother_existance)
    end
    
    c_not_result_sum = cipher.encrypt(0)
    c_not_number_sum = cipher.encrypt(0)
    # とりあえず母親がいない人の平均を計算するa
    c_one = cipher.encrypt(1)
    Student.all.each do |student|
      # 母親がいるかいないかの暗号を文字列から配列に
      c_mother_existance_not = cipher.c_xor(c_one, student.cipher_string_to_array(student.mother_existance))
      c_result = student.cipher_string_to_array(student.result)
      # 0,1を all 0,1 にマッピング
      c_all = Array.new(bit_length).map{ |c| c = c_mother_existance_not[bit_length - 1] }
      # 
      c_not_result_sum = cipher.c_add(c_not_result_sum, cipher.c_and(c_result, c_all))
      c_not_number_sum = cipher.c_add(c_not_number_sum, c_mother_existance_not)
    end
    
    { mother_no_existance: { result_sum: cipher.decrypt(c_not_result_sum), number_sum: cipher.decrypt(c_not_number_sum) }, mother_existance: { result_sum: cipher.decrypt(c_result_sum), number_sum: cipher.decrypt(c_number_sum) } }
  end
end
