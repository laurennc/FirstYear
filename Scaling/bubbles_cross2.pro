PRO BUBBLES_CROSS2, grp_a, grp_b, radii_a, radii_b, NUMBER_CROSS=number_cross,dist_return
;grp_a and grp_b should be the xyz positions of the particles in those groups.

;First, let's compute a distance matrix. Thus for any r_a - r_b[i] = rdist[*,i]
r_dists = findgen(n_elements(grp_a[0,*]),n_elements(grp_b[0,*]))
i = 0.0

while (i lt n_elements(grp_b[0,*])) do begin
	dists = sqrt( ((grp_a[0,*]-grp_b[0,i])^2.0) + ((grp_a[1,*]-grp_b[1,i])^2.0) + ((grp_a[2,*]-grp_b[2,i])^2.0) )
	r_dists[*,i] = dists
	i = i + 1.0
endwhile
r_dists = dist_return

keeping_count = fltarr(n_elements(grp_b[0,*]))
i = 0.0

while (i lt n_elements(grp_b[0,*])) do begin
	k = 0
	print,'i is ',i
	counting = 0.0
	while (k lt n_elements(grp_a[0,*])) do begin
		if (grp_b[0,i] eq grp_a[0,k] AND grp_b[1,i] eq grp_a[1,k] AND grp_b[2,i] eq grp_a[2,k]) then begin
			print,'here I am doing nothing'
		endif else begin
			r_diff = r_dists[k,i]
			print,'r_diff is ',r_diff
			if (r_diff lt (radii_b[i]+radii_a[k])) then begin
				couting = counting + 1.0
			endif
		endelse
		k = k + 1.0
	endwhile
	print,'counting is',couting
	keeping_count[i] = counting
	
	i = i+1.0
endwhile

number_cross = keeping_count
END