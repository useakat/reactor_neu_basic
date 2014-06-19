C -*- fortran -*-
C     Nuclear Power Data are from http://world-nuclear.org/info/Country-Profiles/Countries-O-S/South-Korea/#.UYIxAiv24hw
C
C     reactor mode: 0: use the averaged position of reactor cores
C                   1: use each position of reactor cores

c     YongGwang
c         tokei(1) = 126.416015d0  ! center                                                                                                                                                                
c         hokui(1) = 35.411101d0
c         PP(1) = 16.52d0 ! [MWe]
         tokei(11) = 126.410367d0 ! YongGwang1
         hokui(11) = 35.407687d0
         PP(11) = 0.953d0
         tokei(12) = 126.412630d0 ! YongGwang2
         hokui(12) = 35.409074d0
         PP(12) = 0.947d0
         tokei(13) = 126.414916d0 ! YongGwang3
         hokui(13) = 35.410389d0
         PP(13) = 0.997d0
         tokei(14) = 126.417201d0 ! YongGwang4
         hokui(14) = 35.411784d0
         PP(14) = 0.994d0
         tokei(15) = 126.419465d0 ! YongGwang5
         hokui(15) = 35.413124d0
         PP(15) = 0.988d0
         tokei(16) = 126.421766d0 ! YongGwang6
         hokui(16) = 35.414490d0
         PP(16) = 0.996d0
         if (reactor_mode.eq.0) then
            tokei(1) = (tokei(11)+tokei(12)+tokei(13)+tokei(14)
     &           +tokei(15)+tokei(16))/6d0
            hokui(1) = (hokui(11)+hokui(12)+hokui(13)+hokui(14)
     &           +hokui(15)+hokui(16))/6d0
            PP(1) = PP(11)+PP(12)+PP(13)+PP(14)+PP(15)+PP(16)
         endif

c     Kori
c         tokei(2) = 129.28d0
c         hokui(2) = 35.32d0
c         PP(2) = 22.22d0
         tokei(21) = 129.290067d0 ! Kori1  2017 close
         hokui(21) = 35.319899d0
         PP(21) = 0.576d0
         tokei(22) = 129.291070d0! Kori2
         hokui(22) = 35.320242d0
         PP(22) = 0.637d0
         tokei(23) = 129.294578d0 ! Kori3
         hokui(23) = 35.320041d0
         PP(23) = 1.007d0
         tokei(24) = 129.297279d0 ! Kori4
         hokui(24) = 35.319970d0
         PP(24) = 1.007d0
         tokei(25) = 129.300219d0 ! Shin-Kori1
         hokui(25) = 35.326774d0
         PP(25) = 1.001d0
         tokei(26) = 129.300090d0 ! Shin-Kori2
         hokui(26) = 35.327871d0
         PP(26) = 1.001d0
         tokei(121) = 129.310239d0 ! Shin-Kori3 *estimation
         hokui(121) = 35.337183d0
         PP(121) = 1.350d0
         tokei(122) = 129.310797d0 ! Shin-Kori4 *estimation
         hokui(122) = 35.338551d0
         PP(122) = 1.350d0
         tokei(123) = 129.311548d0 ! Shin-Kori5 *estimation
         hokui(123) = 35.33960d0
         PP(123) = 1.350d0
         tokei(124) = 129.312020d0 ! Shin-Kori6 *estimation
         hokui(124) = 35.341330d0
         PP(124) = 1.350d0
         if (reactor_mode.eq.0) then 
            if (reactor_type.eq.0) then ! add only operating reactors
               tokei(2) = (tokei(21)+tokei(22)+tokei(23)+tokei(24)
     &              +tokei(25)+tokei(26))/6d0
               hokui(2) = (hokui(21)+hokui(22)+hokui(23)+hokui(24)
     &              +hokui(25)+hokui(26))/6d0
               PP(2) = PP(21)+PP(22)+PP(23)+PP(24)+PP(25)+PP(26)
            elseif (reactor_type.eq.1) then ! add planned reactors as well
               tokei(2) = (tokei(22)+tokei(23)+tokei(24)+tokei(25)
     &              +tokei(26)+tokei(121)+tokei(122)+tokei(123)
     &              +tokei(124))/9d0
               hokui(2) = (hokui(22)+hokui(23)+hokui(24)+hokui(25)
     &              +hokui(26)+hokui(121)+hokui(122)+hokui(123)
     &              +hokui(124))/9d0
               PP(2) = PP(22)+PP(23)+PP(24)+PP(25)+PP(26)+PP(121)
     &              +PP(122)+PP(123)+PP(124)
            endif
         endif

c     Wolsong
c         tokei(3) = 129.47d0
c         hokui(3) = 35.70d0
c         PP(3) = 13.38d0
         tokei(31) = 129.473084d0 ! Wolsong1
         hokui(31) = 35.709386d0
         PP(31) = 0.666d0
         tokei(32) = 129.474072d0 ! Wolsong2
         hokui(32) = 35.710538d0
         PP(32) = 0.710d0
         tokei(33) = 129.475477d0 ! Wolsong3
         hokui(33) = 35.712212d0
         PP(33) = 0.707d0
         tokei(34) = 129.476400d0 ! Wolsong4
         hokui(34) = 35.713251d0
         PP(34) = 0.708d0
         tokei(35) = 129.477741d0 ! Shin-Wolsong1
         hokui(35) = 35.721524d0
         PP(35) = 1.001d0
         tokei(131) = 129.478130d0 ! Shin-Wolsong2
         hokui(131) = 35.722547d0
         PP(131) = 1.050d0
         if (reactor_mode.eq.0) then
            if (reactor_type.eq.0) then
               tokei(3) = (tokei(31)+tokei(32)+tokei(33)+tokei(34)
     &              +tokei(35))/5d0
               hokui(3) = (hokui(31)+hokui(32)+hokui(33)+hokui(34)
     &              +hokui(35))/5d0
               PP(3) = PP(31)+PP(32)+PP(33)+PP(34)+PP(35)
            elseif (reactor_type.eq.1) then
               tokei(3) = (tokei(31)+tokei(32)+tokei(33)+tokei(34)
     &              +tokei(35)+tokei(131))/6d0
               hokui(3) = (hokui(31)+hokui(32)+hokui(33)+hokui(34)
     &              +hokui(35)+hokui(131))/6d0
               PP(3) = PP(31)+PP(32)+PP(33)+PP(34)+PP(35)+PP(131)
            endif
         endif

c     Ulchin
c         tokei(4) = 129.38d0
c         hokui(4) = 37.08d0
c         PP(4) = 24.36d0
         tokei(41) = 129.378502d0 ! Ulchin1
         hokui(41) = 37.096039d0
         PP(41) = 0.945d0
         tokei(42) = 129.379167d0 ! Ulchin2
         hokui(42) = 37.095425d0
         PP(42) = 0.942d0
         tokei(43) = 129.381484d0! Ulchin3
         hokui(43) = 37.093633d0
         PP(43) = 0.994d0
         tokei(44) = 129.382901d0! Ulchin4
         hokui(44) = 37.092428d0
         PP(44) = 0.998d0
         tokei(45) = 129.384939d0 ! Ulchin5
         hokui(45) = 37.090602d0
         PP(45) = 1.001d0
         tokei(46) = 129.386366d0 ! Ulchin6
         hokui(46) = 37.089406d0
         PP(46) = 1.001d0
         tokei(141) = 129.388834d0 ! Shin-Ulchin1 * estimation
         hokui(141) = 37.084532d0
         PP(141) = 1.350d0
         tokei(142) = 129.389842d0 ! Shin-Ulchin2 *estimation
         hokui(142) = 37.083465d0
         PP(142) = 1.350d0
         tokei(143) = 129.393426d0 ! Shin-Ulchin3 *estimation
         hokui(143) = 37.080628d0
         PP(143) = 1.350d0
         tokei(144) = 129.395207d0! Shin-Ulchin4 *estimation
         hokui(144) = 37.079133d0
         PP(144) = 1.350d0
         if (reactor_mode.eq.0) then
            if (reactor_type.eq.0) then
               tokei(4) = (tokei(41)+tokei(42)+tokei(43)+tokei(44)
     &              +tokei(45)+tokei(46))/6d0
               hokui(4) = (hokui(41)+hokui(42)+hokui(43)+hokui(44)
     &              +hokui(45)+hokui(46))/6d0
               PP(4) = PP(41)+PP(42)+PP(43)+PP(44)+PP(45)+PP(46)
            elseif (reactor_type.eq.1) then
               tokei(4) = (tokei(41)+tokei(42)+tokei(43)+tokei(44)
     &              +tokei(45)+tokei(46)+tokei(141)+tokei(142)
     &              +tokei(143)+tokei(144))/10d0
               hokui(4) = (hokui(41)+hokui(42)+hokui(43)+hokui(44)
     &              +hokui(45)+hokui(46)+hokui(141)+hokui(142)
     &              +hokui(143)+hokui(144))/10d0
               PP(4) = PP(41)+PP(42)+PP(43)+PP(44)+PP(45)+PP(46)
     &              +PP(141)+PP(142)+PP(143)+PP(144)
            endif
         endif         
