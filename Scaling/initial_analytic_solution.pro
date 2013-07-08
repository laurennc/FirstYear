Function initial_analytic_solution,del_t,lumin_params

	alpha = ((375.0/0.04)/77.0)^(1.0/5.0)

	beta = ((7.0*0.04)/(150.0*!pi))*(alpha^2.0)

	X_0 = alpha*(del_t)^(3.0/5.0)
	Y_0 = ((3.0/5.0)*alpha)/(del_t^(2.0/5.0))
	P_0 = beta/(del_t^(4.0/5.0))

	initial=[P_0,Y_0,X_0]
	return, initial
END