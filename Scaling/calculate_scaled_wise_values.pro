PRO CALCULATE_SCALED_WISE_VALUES,t_start_in,Mass,time_out,radii_out

;Constants
L_sun = 6.3706e-21 ;solar mass kpc^2 yr^-3
G = 4.4986e-24 ;kpc^3 yr^-2 solar mass^-1
H_0 = 7.48609e-11;yr^-1
little_h = 0.732
omega_b = 0.0416
f_sn = 0.01

time_out = findgen(n_elements(Mass))
radii_out = findgen(n_elements(Mass))
;solar_out = findgen(n_elements(Mass))

i = 0.0

while i lt n_elements(Mass) do begin
        print,'i is i',i
        Mdm = Mass[i]
		t_start = t_start_in[i]
		
		
		t_sn = 5e7
		t_end = complete_z_to_t(7.2895) - t_start

		tau_start = 0.0
		tau_sn = t_sn/t_start
		tau_end = (t_end)/t_start



        ;SCALE FACTORS
        t_scale = t_start
        L_scale = 1.2*L_sun*Mdm  ;*omega_b (am using stellar masses)
        H_scale = (2.0/3.0)/(t_scale) ;yr^-1
        R_scale = (L_scale)^0.2 * G^0.2 * t_scale ;kpc
        P_scale = (L_scale)^0.4/(G^0.6 * t_scale^2.0) ;

		lumin_params=[tau_sn,Mdm,11.0,little_h,t_start,L_scale,f_sn]


        h=0.000001
        deriv = 'snwinds_derivs_wechs'
        xp=fltarr(350)
        yp=fltarr(3,350)

        initial = initial_analytic_solution(h,lumin_params)
        ystart = initial

        odeint_snwinds,ystart,tau_start,tau_end,1e-5,h,1e-8,nok,nbad,deriv,lumin_params,xp=xp,yp=yp,count=count

        finding = where(xp eq 0.0)
        end_index = finding[1]-1.0
		time_out[i] = xp(end_index)
        radii_out[i] = yp(2,end_index);*R_scale
        
        ;SHOULD ALSO OUTPUT METALLICITIES
        ;mass_for_metals=wechs_mass(time_out,lumin_params)
        ;yield = 0.01
        ;METAL_WECHS,time_out,mass_for_metals,yield,lumin_params,Z_stars,Z_book,metal_mass,star_mass,gas_mass
        ;solar_out[i] = alog10(Z_stars[end_index]) - alog10(0.02)

        i = i + 1.0
endwhile

END

