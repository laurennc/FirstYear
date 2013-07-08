FUNCTION COMPLETE_T_TO_z, t
	H_0 = 7.48609e-11;yr^-1	
	inner = 0.5*3.0*sqrt(0.762)*H_0*t
	outer = sinh(inner)
	outer = outer*sqrt(0.238/0.762)
	retval = outer^(-2.0/3.0)
	retval = retval - 1.0
	return,retval
END
