#----------------------------------------------------------------------------------------------#
#                                       amounts.test.jl                                        #
#----------------------------------------------------------------------------------------------#

#⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅#
#                                      CONSTRUCTOR TESTS                                       #
#⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅#

@testset "amounts.test.jl: Generic Amount constructor tests                       " begin
    for 𝕋 in (:__amt, )
        for ℙ in (Float16, Float32, Float64, BigFloat)
            for 𝕌 in (
                u"m", u"s", u"m/s", u"N", u"N/m^2", u"J", u"J/s", u"K", u"1/K", u"mol",
                u"mol/s", u"kg/kmol", u"kJ/kg", u"kJ/kg/s", u"kJ/kg/K", u"kJ/kg/K/s",
            )
                #--------------------------------------------------------------------------#
                #                            Exact Constructors                            #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(one(ℙ))                          # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,EX}
                amnt = eval(𝕋)(one(ℙ) * 𝕌)                      # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,EX}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,EX}
                amnt = eval(𝕋){ℙ,EX}(one(ℙ))                    # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,EX}
                amnt = eval(𝕋){ℙ,EX}(one(ℙ) * 𝕌)                # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,EX}
                #--------------------------------------------------------------------------#
                #                         Measurements Constructor                         #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(one(ℙ) ± one(ℙ)/ℙ(10))           # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,MM}
                amnt = eval(𝕋)((one(ℙ) ± one(ℙ)/ℙ(10)) * 𝕌)     # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,MM}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,MM}
                amnt = eval(𝕋){ℙ,MM}(one(ℙ) ± one(ℙ))           # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,MM}
                amnt = eval(𝕋){ℙ,MM}((one(ℙ) ± one(ℙ)) * 𝕌)     # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,MM}
            end
        end
        for 𝕍 in Real[Irrational{:ℯ}(), Irrational{:π}(), 2//3, 1//10, 3, 2]
            for 𝕌 in (
                u"m", u"s", u"m/s", u"N", u"N/m^2", u"J", u"J/s", u"K", u"1/K", u"mol",
                u"mol/s", u"kg/kmol", u"kJ/kg", u"kJ/kg/s", u"kJ/kg/K", u"kJ/kg/K/s",
            )
                #--------------------------------------------------------------------------#
                #                            Exact Constructors                            #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(𝕍)                               # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,EX}
                amnt = eval(𝕋)(𝕍 * 𝕌)                           # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,EX}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,EX}
                amnt = eval(𝕋){Float64,EX}(𝕍)                   # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,EX}
                amnt = eval(𝕋){Float64,EX}(𝕍 * 𝕌)               # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){Float64,EX}
                #--------------------------------------------------------------------------#
                #                         Measurements Constructor                         #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(𝕍 ± 𝕍)                           # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,MM}
                amnt = eval(𝕋)((𝕍 ± 𝕍) * 𝕌)                     # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,MM}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,MM}
                amnt = eval(𝕋){Float64,MM}(𝕍 ± 𝕍)               # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,MM}
                amnt = eval(𝕋){Float64,MM}((𝕍 ± 𝕍) * 𝕌)         # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){Float64,MM}
            end
        end
    end
end


@testset "amounts.test.jl: Whole Amount constructor tests                         " begin
    for 𝕋 in (:T_amt, :P_amt, :veamt, :spamt, :t_amt, :gvamt, :z_amt,
              :Z_amt, :gaamt, :beamt, :kTamt, :ksamt, :k_amt, :csamt,
              :Maamt, :mJamt, :mSamt, :x_amt, :Pramt, :vramt, :ø_amt)
        for ℙ in (Float16, Float32, Float64, BigFloat)
            # Obtain corresponding 𝕋 amount's units
            𝕌 = unit(eval(𝕋)(one(ℙ))())
            #--------------------------------------------------------------------------#
            #                            Exact Constructors                            #
            #--------------------------------------------------------------------------#
            amnt = eval(𝕋)(one(ℙ))                          # unitless arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){ℙ}
            @test amnt isa eval(𝕋){ℙ,EX}
            amnt = eval(𝕋)(one(ℙ) * 𝕌)                      # unit-ed arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){ℙ}
            @test amnt isa eval(𝕋){ℙ,EX}
            amnt = eval(𝕋)(amnt)                            # copy constructor
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){ℙ}
            @test amnt isa eval(𝕋){ℙ,EX}
            amnt = eval(𝕋){ℙ}(one(ℙ))                       # non-conv, fully spec'd
            @test amnt isa eval(𝕋){ℙ,EX}
            amnt = eval(𝕋){ℙ,EX}(one(ℙ))                    # non-conv, fully spec'd
            @test amnt isa eval(𝕋){ℙ,EX}
            amnt = eval(𝕋){ℙ}(one(ℙ) * 𝕌)                   # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){ℙ,EX}
            amnt = eval(𝕋){ℙ,EX}(one(ℙ) * 𝕌)                # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){ℙ,EX}
            #--------------------------------------------------------------------------#
            #                         Measurements Constructor                         #
            #--------------------------------------------------------------------------#
            amnt = eval(𝕋)(one(ℙ) ± one(ℙ)/ℙ(10))           # unitless arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){ℙ}
            @test amnt isa eval(𝕋){ℙ,MM}
            amnt = eval(𝕋)((one(ℙ) ± one(ℙ)/ℙ(10)) * 𝕌)     # unit-ed arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){ℙ}
            @test amnt isa eval(𝕋){ℙ,MM}
            amnt = eval(𝕋)(amnt)                            # copy constructor
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){ℙ}
            @test amnt isa eval(𝕋){ℙ,MM}
            amnt = eval(𝕋){ℙ}(one(ℙ) ± one(ℙ))              # non-conv, fully spec'd
            @test amnt isa eval(𝕋){ℙ,MM}
            amnt = eval(𝕋){ℙ,MM}(one(ℙ) ± one(ℙ))           # non-conv, fully spec'd
            @test amnt isa eval(𝕋){ℙ,MM}
            amnt = eval(𝕋){ℙ}((one(ℙ) ± one(ℙ)) * 𝕌)        # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){ℙ,MM}
            amnt = eval(𝕋){ℙ,MM}((one(ℙ) ± one(ℙ)) * 𝕌)     # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){ℙ,MM}
        end
        for 𝕍 in Real[Irrational{:ℯ}(), Irrational{:π}(), 2//3, 1//10, 3, 2]
            # Obtain corresponding 𝕋 amount's units
            𝕌 = unit(eval(𝕋)(𝕍)())
            #--------------------------------------------------------------------------#
            #                            Exact Constructors                            #
            #--------------------------------------------------------------------------#
            amnt = eval(𝕋)(𝕍)                               # unitless arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){Float64}
            @test amnt isa eval(𝕋){Float64,EX}
            amnt = eval(𝕋)(𝕍 * 𝕌)                           # unit-ed arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){Float64}
            @test amnt isa eval(𝕋){Float64,EX}
            amnt = eval(𝕋)(amnt)                            # copy constructor
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){Float64}
            @test amnt isa eval(𝕋){Float64,EX}
            amnt = eval(𝕋){Float64}(𝕍)                      # non-conv, fully spec'd
            @test amnt isa eval(𝕋){Float64,EX}
            amnt = eval(𝕋){Float64,EX}(𝕍)                   # non-conv, fully spec'd
            @test amnt isa eval(𝕋){Float64,EX}
            amnt = eval(𝕋){Float64}(𝕍 * 𝕌)                  # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){Float64,EX}
            amnt = eval(𝕋){Float64,EX}(𝕍 * 𝕌)               # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){Float64,EX}
            #--------------------------------------------------------------------------#
            #                         Measurements Constructor                         #
            #--------------------------------------------------------------------------#
            amnt = eval(𝕋)(𝕍 ± 𝕍)                           # unitless arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){Float64}
            @test amnt isa eval(𝕋){Float64,MM}
            amnt = eval(𝕋)((𝕍 ± 𝕍) * 𝕌)                     # unit-ed arg
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){Float64}
            @test amnt isa eval(𝕋){Float64,MM}
            amnt = eval(𝕋)(amnt)                            # copy constructor
            @test amnt isa eval(𝕋)
            @test amnt isa eval(𝕋){Float64}
            @test amnt isa eval(𝕋){Float64,MM}
            amnt = eval(𝕋){Float64}(𝕍 ± 𝕍)                  # non-conv, fully spec'd
            @test amnt isa eval(𝕋){Float64,MM}
            amnt = eval(𝕋){Float64,MM}(𝕍 ± 𝕍)               # non-conv, fully spec'd
            @test amnt isa eval(𝕋){Float64,MM}
            amnt = eval(𝕋){Float64}((𝕍 ± 𝕍) * 𝕌)            # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){Float64,MM}
            amnt = eval(𝕋){Float64,MM}((𝕍 ± 𝕍) * 𝕌)         # non-conv, fully spec'd, unit
            @test amnt isa eval(𝕋){Float64,MM}
        end
    end
end


@testset "amounts.test.jl: Based Amount constructor tests                         " begin
    for 𝕋 in (:m_amt, :N_amt, :R_amt, :Pvamt, :RTamt, :Tsamt, :v_amt,
              :u_amt, :h_amt, :g_amt, :a_amt, :e_amt, :ekamt, :epamt,
              :s_amt, :cpamt, :cvamt, :c_amt, :j_amt, :y_amt, :xiamt,
              :dxamt, :psamt, :dpamt, :q_amt, :w_amt, :deamt, :dsamt,
              :i_amt)
        for ℙ in (Float16, Float32, Float64, BigFloat)
            for 𝔹 in (SY, DT, MA, MO)
                # Obtain corresponding 𝕋 amount's units
                𝕌 = unit(eval(𝕋)(one(ℙ), 𝔹)())
                #--------------------------------------------------------------------------#
                #                            Exact Constructors                            #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(one(ℙ), 𝔹)                       # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,EX}
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋)(one(ℙ) * 𝕌, 𝔹)                   # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,EX}
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,EX}
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋){ℙ}(one(ℙ), 𝔹)                    # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋){ℙ,EX}(one(ℙ), 𝔹)                 # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋){ℙ,EX,𝔹}(one(ℙ), 𝔹)               # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋){ℙ}(one(ℙ) * 𝕌, 𝔹)                # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋){ℙ,EX}(one(ℙ) * 𝕌, 𝔹)             # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                amnt = eval(𝕋){ℙ,EX,𝔹}(one(ℙ) * 𝕌, 𝔹)           # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,EX,𝔹}
                #--------------------------------------------------------------------------#
                #                         Measurements Constructor                         #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(one(ℙ) ± one(ℙ), 𝔹)              # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,MM}
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋)((one(ℙ) ± one(ℙ)) * 𝕌, 𝔹)        # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,MM}
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){ℙ}
                @test amnt isa eval(𝕋){ℙ,MM}
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋){ℙ}(one(ℙ) ± one(ℙ), 𝔹)           # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋){ℙ,MM}(one(ℙ) ± one(ℙ), 𝔹)        # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋){ℙ,MM,𝔹}(one(ℙ) ± one(ℙ), 𝔹)      # non-conv, fully spec'd
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋){ℙ}((one(ℙ) ± one(ℙ)) * 𝕌, 𝔹)     # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋){ℙ,MM}((one(ℙ) ± one(ℙ)) * 𝕌, 𝔹)  # non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
                amnt = eval(𝕋){ℙ,MM,𝔹}((one(ℙ) ± one(ℙ)) * 𝕌, 𝔹)# non-conv, fully spec'd, unit
                @test amnt isa eval(𝕋){ℙ,MM,𝔹}
            end
        end
        for 𝕍 in Real[Irrational{:ℯ}(), Irrational{:π}(), 2//3, 1//10, 3, 2]
            for 𝔹 in (SY, DT, MA, MO)
                # Obtain corresponding 𝕋 amount's units
                𝕌 = unit(eval(𝕋)(𝕍, 𝔹)())
                #--------------------------------------------------------------------------#
                #                            Exact Constructors                            #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(𝕍, 𝔹)                            # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,EX}
                @test amnt isa eval(𝕋){Float64,EX,𝔹}
                amnt = eval(𝕋)(𝕍 * 𝕌, 𝔹)                        # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,EX}
                @test amnt isa eval(𝕋){Float64,EX,𝔹}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,EX}
                @test amnt isa eval(𝕋){Float64,EX,𝔹}
                amnt = eval(𝕋){Float64}(𝕍 * 𝕌, 𝔹)               # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,EX,𝔹}
                amnt = eval(𝕋){Float64,EX}(𝕍 * 𝕌, 𝔹)            # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,EX,𝔹}
                amnt = eval(𝕋){Float64,EX,𝔹}(𝕍 * 𝕌, 𝔹)          # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,EX,𝔹}
                #--------------------------------------------------------------------------#
                #                         Measurements Constructor                         #
                #--------------------------------------------------------------------------#
                amnt = eval(𝕋)(𝕍 ± 𝕍, 𝔹)                        # unitless arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,MM}
                @test amnt isa eval(𝕋){Float64,MM,𝔹}
                amnt = eval(𝕋)((𝕍 ± 𝕍) * 𝕌, 𝔹)                  # unit-ed arg
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,MM}
                @test amnt isa eval(𝕋){Float64,MM,𝔹}
                amnt = eval(𝕋)((𝕍 ± 𝕍) * 𝕌)                     # no BASE: acid test for 𝕌 == DLESS
                @test amnt isa eval(𝕋){Float64,MM,𝔹}
                amnt = eval(𝕋)(amnt)                            # copy constructor
                @test amnt isa eval(𝕋)
                @test amnt isa eval(𝕋){Float64}
                @test amnt isa eval(𝕋){Float64,MM}
                @test amnt isa eval(𝕋){Float64,MM,𝔹}
                amnt = eval(𝕋){Float64}((𝕍 ± 𝕍) * 𝕌, 𝔹)         # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,MM,𝔹}
                amnt = eval(𝕋){Float64,MM}((𝕍 ± 𝕍) * 𝕌, 𝔹)      # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,MM,𝔹}
                amnt = eval(𝕋){Float64,MM,𝔹}((𝕍 ± 𝕍) * 𝕌, 𝔹)    # non-conv, fully spec'd
                @test amnt isa eval(𝕋){Float64,MM,𝔹}
            end
        end
    end
end


#⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅#
#                                       CONVERSION TESTS                                       #
#⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅#

@testset "amounts.test.jl: Generic Amount conversion tests                        " begin
    vec01 = [
        eval(𝕋)(one(ℙ) * 𝕌 / 10)
            for 𝕋 in (:__amt, )
                for ℙ in (Float16, Float32, Float64, BigFloat) 
                    for 𝕌 in (u"m", u"m/s", u"kJ/kg/s", u"kJ/kmol/K")
    ]
    @test typeof(vec01) == Vector{__amt{𝗽, EX} where 𝗽}
    vec02 = [
        eval(𝕋)((one(ℙ) ± one(ℙ)) * 𝕌 / 10)
            for 𝕋 in (:__amt, )
                for ℙ in (Float16, Float32, Float64, BigFloat) 
                    for 𝕌 in (u"m", u"m/s", u"kJ/kg/s", u"kJ/kmol/K")
    ]
    @test typeof(vec02) == Vector{__amt{𝗽, MM} where 𝗽}
    vec03 = [
        eval(𝕋)(𝕍 * 𝕌)
            for 𝕋 in (:__amt, )
                for 𝕍 in Real[Irrational{:ℯ}(), 1//10, 3]
                    for 𝕌 in (u"m", u"m/s", u"kJ/kg/s", u"kJ/kmol/K")
    ]
    @test typeof(vec03) == Vector{__amt{Float64, EX}}
    # IMPLIED CONVERSION THROUGH CONCATENATION
    @test typeof(vcat(vec01, vec02)) == Vector{__amt{𝗽,𝘅} where {𝗽,𝘅}}
    @test typeof(vcat(vec01, vec03)) == Vector{__amt{𝗽,EX} where {𝗽}}
    @test typeof(vcat(vec02, vec03)) == Vector{__amt{𝗽,𝘅} where {𝗽,𝘅}}
    for DST in (:__amt, :GenerAmt, :AMOUNTS)
        𝔻 = eval(DST)
        for ℙ in (Float16, Float32, Float64, BigFloat)
            # Type- and Precision- Conversions
            @test typeof(𝔻{ℙ}[vec01...]) == Vector{𝔻{ℙ}}
            @test typeof(𝔻{ℙ}[vec02...]) == Vector{𝔻{ℙ}}
            @test typeof(𝔻{ℙ}[vec03...]) == Vector{𝔻{ℙ}}
            @test typeof(𝔻{ℙ}[vec01..., vec02...]) == Vector{𝔻{ℙ}}
            @test typeof(𝔻{ℙ}[vec01..., vec03...]) == Vector{𝔻{ℙ}}
            @test typeof(𝔻{ℙ}[vec02..., vec03...]) == Vector{𝔻{ℙ}}
            # Type-, Precision- and Exactness- Conversions
            for 𝕏 in (EX, MM)
                @test typeof(𝔻{ℙ,𝕏}[vec01...]) == Vector{𝔻{ℙ,𝕏}}
                @test typeof(𝔻{ℙ,𝕏}[vec02...]) == Vector{𝔻{ℙ,𝕏}}
                @test typeof(𝔻{ℙ,𝕏}[vec03...]) == Vector{𝔻{ℙ,𝕏}}
                @test typeof(𝔻{ℙ,𝕏}[vec01..., vec02...]) == Vector{𝔻{ℙ,𝕏}}
                @test typeof(𝔻{ℙ,𝕏}[vec01..., vec03...]) == Vector{𝔻{ℙ,𝕏}}
                @test typeof(𝔻{ℙ,𝕏}[vec02..., vec03...]) == Vector{𝔻{ℙ,𝕏}}
            end
        end
    end
end




