class MyCipher
  def initialize(bit_length, private_key, public_key)
    @bit_length = bit_length
    @private_key = private_key
    @public_key = public_key
    @rand_max = 500
  end

  # 暗号化してreturn
  def encrypt(data)
    cut_data = cut_to_string(data)
    # c = m + R * k 
    cut_data.map{ |m| m + rk }
  end

  # 復号してreturn
  def decrypt(data)
    # m = c mod K mod 2
    decrypted_data = data.map{ |c| (c % @private_key) % 2 }
    decrypted_data.map(&:to_s).join('').to_i(2)
  end

  def bit_encrypt(num)
    num + rk
  end

  def c_xor(c1, c2)
    a1, a2 = size_unification(c1, c2)
    c3 = []
    a1.size.times do |i|
      c3[i] = (a1[i] + a2[i])
    end
    c3
  end

  def c_and(c1, c2)
    a1, a2 = size_unification(c1, c2)
    c3 = []
    a1.size.times do |i|
      c3[i] = (a1[i] * a2[i])
    end
    c3
  end

  # すべてのbitとxorをとる
  def c_not(c1)
    a1 = c1.clone
    c_all_one = Array.new(@bit_length, bit_encrypt(1))
    c_xor(c1, c_all_one)
  end

  def c_equal?(c1, c2)
    a1, a2 = size_unification(c1, c2)
    a3 = c_not(c_xor(a1, a2))
    c_one = encrypt(1)
    a3.map{ |a| c_one = c_and([a], c_one) }
    c_one
  end

  private
  
  def cut_to_string(data)
    cut_data = data.to_s(2).rjust(@bit_length, '0').split('')
    cut_data.map!{ |n| n.to_i(2) }
  end

  def size_unification(a1, a2)
    distance = (a1.size - a2.size).abs
    if a1.size > a2.size
      distance.times do
        a2.unshift(bit_encrypt(0))
      end
    elsif a1.size < a2.size
      distance.times do
        a1.unshift(bit_encrypt(0))
      end
    end
    [a1, a2]
  end

  def rk
    Random.new.rand(@rand_max) * @public_key
  end
end
