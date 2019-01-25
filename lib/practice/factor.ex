defmodule Practice.Factor do
	defp parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end
	# Get the prime factors of odd numbers
	def oddFactor(n, f, lp) when n < f do
		lp
	end
	def oddFactor(n, f, lp) when rem(n, f) == 0 do
		[f | oddFactor(div(n,f), f, lp)]
	end
	def oddFactor(n, f, lp) do
		oddFactor(n, f + 2, lp)
	end
	# Set up cases for the factor fuction, need a list number and a prime divisor
	def getFactors(n, lp) when n < 2 do
		lp
	end
	# Shave the number down until its definitely odd
	def getFactors(n, lp) when rem(n, 2) == 0 do
		[2 | getFactors(div(n,2), lp)]
	end
	# Once the number is odd call the odd factorization function
	def getFactors(n, lp) do
		oddFactor(n, 3, lp)
	end

	def factor(n) do
		inspect(getFactors(parse_int(n), []))
	end
end
