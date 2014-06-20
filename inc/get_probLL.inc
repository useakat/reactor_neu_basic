C -*- fortran -*-
         if (reactor_mode.eq.0) then
            probLL = 0d0
            do i = 1,nr
               probLL = probLL +flux(E,PP(i))
     &              *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
            enddo
         elseif (reactor_mode.eq.1) then
            probLL = 0d0
            if (reactor_type.eq.0) then
               if (nr.ge.1) then
                  do i = 11,16
c                  do i = 1,1
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
               if (nr.ge.2) then
                  do i = 21,26
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
               if (nr.ge.3) then
                  do i = 31,35
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
               if (nr.ge.4) then
                  do i = 41,46
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
            elseif (reactor_type.eq.1) then
               if (nr.ge.1) then
                  do i = 11,16
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
               if (nr.ge.2) then
                  do i = 21,26
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
                  do i = 121,124
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
               if (nr.ge.3) then
                  do i = 31,35
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
                  do i = 131,131
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
               if (nr.ge.4) then
                  do i = 41,46
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
                  do i = 141,144
                     probLL = probLL +flux(E,PP(i))
     &                    *prob_ee(LL(i)/E,z,error,sign,iPee,0)/(4*pi*(LL(i)*1d5)**2)
                  enddo
               endif
            endif
         endif
