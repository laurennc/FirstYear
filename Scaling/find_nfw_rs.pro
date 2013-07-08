FUNCTION FIND_NFW_RS, xin, input
	r_half = input[0]	
	r_out = input[1]

	part1 = (2.0*xin)/(xin+r_half) + 2.0*alog(xin+r_half)
	part2 = (xin)/(xin+r_out) + alog(xin + r_out)
	retval = part1 - part2

RETURN, retval
END
