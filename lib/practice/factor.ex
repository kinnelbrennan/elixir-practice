defmodule Practice.Factor do
	def getFactors(n, f, lp) when n < f do
		lp
	end
	def getFactors(n, f, lp) when rem(n, f) == 0 do
		[f | getFactors(div(n,f), f, lp)]
	end
	def getFactors(n, f, lp) do
		getFactors(n, f + 1, lp)
	end
	
	def factor(n) do
		getFactors(n, 2, [])
	end
end
		
		
