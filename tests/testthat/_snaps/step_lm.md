# stepwise linear model

    Code
      step_lm(data_wider = mtcars, formula = mpg ~ ., trace = FALSE)
    Output
      
      Call:
      lm(formula = mpg ~ wt + qsec + am, data = complete_data)
      
      Coefficients:
      (Intercept)           wt         qsec           am  
            9.618       -3.917        1.226        2.936  
      

