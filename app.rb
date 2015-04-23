require 'sinatra'

set :bind, '0.0.0.0'
set :port, 8080

SCALE = 10000  
ARRINIT = 2000  

# from http://www.codecodex.com/wiki/Calculate_digits_of_pi#Ruby 
# no idea if it really generates valid results but it definitely chews up cpu time
def pi_digits(digits)  
  pi = ""  
  carry = 0  
  arr = Array.new(digits + 1, ARRINIT)  
  digits.step(1, -14) do |i|  
    sum = 0  
    i.downto(1) do |j|  
      sum = sum * j + SCALE * arr[j]  
      arr[j] = sum % (j * 2 - 1)  
      sum /= j * 2 - 1  
    end  
    pi << sprintf("%04d", carry + sum / SCALE)  
    carry = sum % SCALE;  
  end  
  pi  
end 

get '/' do
  puts pi_digits(100000)
end
