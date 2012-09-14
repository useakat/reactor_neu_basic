      minflag = 0
      imode = int(zz(8))

      z_dat(1) = zz(9)
      z_dat(2) = zz(11)
      z_dat(3) = zz(13)
      z_dat(4) = zz(15)
      z_dat(5) = zz(17)
      error(1) = zz(10)
      error(2) = zz(12)
      error(3) = zz(14)
      error(4) = zz(16)
      error(5) = zz(18)

      z_dat(6) = zz(2)                  ! NH/IH
      z_dat(7) = zz(4)*zz(5)*1d9*avog   ! N_target
      z_dat(8) = zz(3)                  ! Power [GW]
      z_dat(9) = zz(6)*y2s              ! Exposure time [s]
      z_dat(10) = 20                     ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]
      z_dat(11) = zz(1)                  ! L [km]
      z(6) = -1*z_dat(6)
      z(7) = z_dat(7)
      z(8) = z_dat(8)
      z(9) = z_dat(9)
      z(10) = z_dat(10)
      z(11) = z_dat(11)

      serror = zz(21)
      snmax = zz(22)
      Emin = zz(19)  ! Emin > 1.80473
      Emax = zz(20)
      Eres = zz(7)

      rdx = 0.005d0

      nevent = 0