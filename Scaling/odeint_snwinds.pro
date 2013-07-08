function sgn,x,y


if y ne 0.0 then s = y/abs(y) else s = 1.
return,s*x

end

; $Id: odeint.pro,v 1.2 2000/08/07 20:41:23 aake Exp $

pro rkck_snwinds,y,dydx,x,h,yout,yerr,derivs,lumin_params

;      INTEGER n,NMAX
;      REAL h,x,dydx(n),y(n),yerr(n),yout(n)
;      EXTERNAL derivs
;      PARAMETER (NMAX=50)
;CU    USES derivs
;      INTEGER i
;      REAL ak2(NMAX),ak3(NMAX),ak4(NMAX),ak5(NMAX),ak6(NMAX),
;     *ytemp(NMAX)

A2 =.2  &  A3 =.3      &  A4 =.6      &  A5 =1.  &  A6 =.875
B21=.2  &  B31=3./40.  &  B32=9./40.  &  B41=.3  &  B42=-.9
B43=1.2 &  B51=-11./54.  &  B52=2.5  &  B53=-70./27.  &  B54=35./27.
B61=1631./55296.  &  B62=175./512.  &  B63=575./13824.
B64=44275./110592.  &  B65=253./4096.
C1=37./378.  &  C3=250./621.  &  C4=125./594.  &  C6=512./1771.
DC1=C1-2825./27648.  &  DC3=C3-18575./48384.
DC4=C4-13525./55296.  &  DC5=-277./14336.  &  DC6=C6-.25

ytemp = y+B21*h*dydx
ak2   = call_function(derivs,x+A2*h,ytemp,lumin_params);,h)
ytemp = y+h*(B31*dydx+B32*ak2)
ak3   = call_function(derivs,x+A3*h,ytemp,lumin_params);,h)
ytemp = y+h*(B41*dydx+B42*ak2+B43*ak3)
ak4   = call_function(derivs,x+A4*h,ytemp,lumin_params);,h)
ytemp = y+h*(B51*dydx+B52*ak2+B53*ak3+B54*ak4)
ak5   = call_function(derivs,x+A5*h,ytemp,lumin_params);,h)
ytemp = y+h*(B61*dydx+B62*ak2+B63*ak3+B64*ak4+B65*ak5)
ak6   = call_function(derivs,x+A6*h,ytemp,lumin_params);,h)
yout  = y+h*(C1*dydx+C3*ak3+C4*ak4+C6*ak6)
yerr  = h*(DC1*dydx+DC3*ak3+DC4*ak4+DC5*ak5+DC6*ak6)

end
;-------------------------------------------------------------


pro rkqs_snwinds,y,dydx,x,htry,eps,yscal,hdid,hnext,derivs,lumin_params
;      INTEGER n,NMAX
;      REAL eps,hdid,hnext,htry,x,dydx(n),y(n),yscal(n)
;      EXTERNAL derivs
;      PARAMETER (NMAX=50)
;CU    USES derivs,rkck
;      INTEGER i
;      REAL errmax,h,htemp,xnew,yerr(NMAX),ytemp(NMAX),SAFETY,PGROW,
;     *PSHRNK,ERRCON
;      PARAMETER (SAFETY=0.9,PGROW=-.2,PSHRNK=-.25,ERRCON=1.89e-4)
SAFETY=0.9
PGROW =-.2
PSHRNK=-.25
ERRCON=1.89e-4

h=htry
errflag = 1
while (errflag) do begin
  ;print, 'h is ',h
  rkck_snwinds,y,dydx,x,h,ytemp,yerr,derivs,lumin_params


  errmax=max(abs(yerr/yscal))
  errmax=errmax/eps
  if (errmax gt 1.) then begin
    htemp=SAFETY*h*(errmax^PSHRNK)
    h=sgn(max([abs(htemp),0.1*abs(h)]),h)
    xnew=x+h
    if (xnew eq x) then stop,'stepsize underflow in rkqs'
  endif else $
    errflag = 0
end
if (errmax gt ERRCON) then  $
  hnext=SAFETY*h*(errmax^PGROW)  $
else  $
  hnext=5.*h
hdid=h
x=x+h
y=ytemp

end

;---------------------------------------------------------------
pro odeint_snwinds,ystart,x1,x2,eps,h1,hmin,nok,nbad,derivs,lumin_params, $
    dxsav=dxsav,xp=xp,yp=yp,count=count,hwant=hwant,verbose=verbose
;      INTEGER nbad,nok,nvar,KMAXX,MAXSTP,NMAX
;      REAL eps,h1,hmin,x1,x2,ystart(nvar),TINY
;      EXTERNAL derivs,rkqs
;      PARAMETER (MAXSTP=10000,NMAX=50,KMAXX=200,TINY=1.e-30)
;      INTEGER i,kmax,count,nstp
;      REAL dxsav,h,hdid,hnext,x,xsav,dydx(NMAX),xp(KMAXX),y(NMAX),
;     *yp(NMAX,KMAXX),yscal(NMAX)
;      COMMON /path/ kmax,count,dxsav,xp,yp
if n_elements(ystart) eq 0 then begin
  print,'odeint,ystart,x1,x2,eps,h1,hmin,nok,nbad,derivs,lumin_params'
  print,'       dxsav=dxsav,xp=xp,yp=yp,count=count,hwant=hwant,verbose=verbose'
  return
endif

MAXSTP=10000
TINY=1.e-30

if n_elements(verbose) eq 0 then $
  verbose=MAXSTP+1 $
else verbose=max([10,verbose])

x=x1
h = 1.0
h=sgn(h1,x2-x1)
signh=sgn(1.,x2-x1)
nok=0
nbad=0
count=-1
y=ystart

kmax=0
if (n_elements(xp) ne 0) then begin
    if ((size(xp))(0) eq 1) then begin
        kmax=(size(xp))(1)
        yp=fltarr((size(ystart))(1),kmax)
    endif else begin
        print,'odeint: xp should be 1-d array'
        return
    endelse
endif

if (n_elements(dxsav) eq 0) then dxsav=hmin
if (n_elements(hwant) eq 0) then hwant=abs(2.*(x2-x1))

hwant = max([hmin,hwant])
;print,'hmin, hwant: ',hmin,hwant

;ADDED BY ME 6/2
;h_out = fltarr(1100)
;count_lauren = 0.0

if (kmax gt 0) then xsav=x-2.*dxsav

for nstp=1,MAXSTP do begin
    ;print,'before the problem call!'
    ;print,'h is ',h
    ;print,h
    dydx = call_function(derivs,x,y,lumin_params);,h)
    yscal=abs(y)+abs(h*dydx)+TINY
    if (kmax gt 0) then begin
        if (abs(x-xsav) gt abs(dxsav)) then begin
            if (count lt kmax-1) then begin
                count=count+1
                xp(count)=x
                yp(*,count)=y
                xsav=x
            endif
        endif
    endif
    if ((x+h-x2)*(x+h-x1) gt 0.) then h=x2-x
    rkqs_snwinds,y,dydx,x,h,eps,yscal,hdid,hnext,derivs,lumin_params
;print,x,hdid,hnext
	;h_out[count_lauren] = h
	;count_lauren = count_lauren + 1.0
	
    if (hdid eq h) then $
      nok=nok+1 $
    else $
      nbad=nbad+1
    if ((x-x2)*(x2-x1) ge 0.) then begin
        ystart=y
        if (kmax ne 0) then begin
            count=count+1
            xp(count)=x
            yp(*,count)=y
        endif
        return
    endif
    if (abs(hnext) lt hmin) then $
      stop,'stepsize smaller than minimum in odeint'
;    h=hnext
    h=signh*min(abs([hnext,hwant]))
    if (nstp mod verbose eq 0) then $
      print,'odeint: step ',nstp,' stepsize ',h
end
stop,'too many steps in odeint'
return
END
