FUNCTION COMPLETE_Z_TO_T, z
	H_0 = 7.48609e-11;yr^-1	
	part1 = (1.0+z)^(3.0/2.0)
	inner = sqrt(0.762/0.238) * (1.0/part1)
	outer = (2.0/3.0)*(1.0/sqrt(0.762))*asinh(inner)
	retval = outer/H_0
	return,retval
END
