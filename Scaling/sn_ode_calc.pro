PRO SN_ODE_CALC,z_start,z_end,Mass,grps,radii_out,solar_out


;Constants
L_sun = 6.3706e-21 ;solar mass kpc^2 yr^-3
G = 4.4986e-24 ;kpc^3 yr^-2 solar mass^-1
H_0 = 7.48609e-11;yr^-1
little_h = 0.732
omega_b = 0.0416


t_start = complete_z_to_t(z_start) ;INPUT VARIABLE HERE
t_sn = 5e7
t_end = complete_z_to_t(z_end) - t_start

tau_start = 0.0
tau_sn = t_sn/t_start
tau_end = (t_end)/t_start


Mdm = Mass[i]

;SCALE FACTORS
t_scale = t_start
L_scale = 1.2*L_sun*Mdm*omega_b
H_scale = (2.0/3.0)/(t_scale) ;yr^-1
R_scale = (L_scale)^0.2 * G^0.2 * t_scale ;kpc
P_scale = (L_scale)^0.4/(G^0.6 * t_scale^2.0) ;


lumin_params=[tau_sn,Mdm,11.0,little_h,t_start,L_scale,f_sfr]


h=0.000001
deriv = 'snwinds_derivs_wechs'
xp=fltarr(350)
yp=fltarr(3,350)

initial = initial_analytic_solution(h,lumin_params)
ystart = initial

odeint_snwinds,ystart,tau_start,tau_end,1e-5,h,1e-8,nok,nbad,deriv,lumin_params,xp=xp,yp=yp,count=count

;SET UP THE OUTPUT THAT I WANT
;GOING TO RETURN THE SCALED VARIABLES FOR NOW
finding = where(xp eq 0.0)
end_index = finding[1]-1.0

time_out = xp(0:end_index)
radii_out = yp(2,0:end_index)


END

