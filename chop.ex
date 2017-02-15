defmodule Chop do
    # :bigger :smaller :equal
    # Enum.split(1..10,(10-1)/2)
    
    # when the range only contains 1 element, that is the answer
    def guess(target, low..high) do
        # entry point
        # idk if float is an issue
        guess(target, low..high, (high-low)/2)
    end
    def guess(target, low..high, theguess) when theguess==target do
        # the anchor case/ terminating condition
        theguess
    end
    def guess(target, low..high, theguess) when theguess>target do
        # lower half
    end
    def guess(target, low..high, theguess) when theguess==target do
        # upper half
    end
    
    
    
    def guess(target, low..high, theguess) when rem(high-low,2)==0 do
        # ODD case, middle is Float.round((high-low)/2)
        
    end
    def guess(target, low..high, theguess) when rem(high-low,2)>0 do
        # EVEN case, middle is (high-low)/2
    end
end