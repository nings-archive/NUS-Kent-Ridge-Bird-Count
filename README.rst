Estimating Wild Bird Populations in NUS Kent Ridge
==================================================

For `ULS2208
<http://www.usp.nus.edu.sg/curriculum/module-timetable/uls2208>`_.

Table of Contents
-----------------

1. `Sanitising the Input`_
2. `Calculating Basic Statistics`_
3. `Finding Total Observations per Species`_
4. `Comparing Observations Across Groups`_
5. `Comparing Observations Across Time Periods`_
6. `Comparing Observations per Survey Across Time Periods`_
7. `Comparing Observations per Distance Bin`_

Sanitising the Input
--------------------

:File: 
  `01-clean_data.ipynb
  <01-clean_data.ipynb>`_
:Type: Jupyter notebook
:Output: None
:Graphs: None

Calculating Basic Statistics
----------------------------

:File:
  `02-basic_stats.r
  <02-basic_stats.r>`_
:Type: Rscript
:Output:
  ::
  
    Calculating for Javan myna
    Mean Density: 10.38963
    Std err. of Mean Density: 0.8542314
    Lower CI: 8.705127
    Upper CI: 12.07414
    %CV: 116.276%
    Total Individuals: 15.58445
    Std err. of Total Individuals: 1.281347
    
    Calculating for Yellow-vented bulbul
    Mean Density: 6.850029
    Std err. of Mean Density: 0.6692195
    Lower CI: 5.530357
    Upper CI: 8.1697
    %CV: 138.1628%
    Total Individuals: 10.27504
    Std err. of Total Individuals: 1.003829
    
    Calculating for Olive-backed sunbird
    Mean Density: 4.25262
    Std err. of Mean Density: 0.5496411
    Lower CI: 3.168752
    Upper CI: 5.336488
    %CV: 182.7838%
    Total Individuals: 6.37893
    Std err. of Total Individuals: 0.8244617
    
    Calculating for Rock pigeon
    Mean Density: 2.164507
    Std err. of Mean Density: 0.6432395
    Lower CI: 0.8960669
    Upper CI: 3.432948
    %CV: 420.2702%
    Total Individuals: 3.246761
    Std err. of Total Individuals: 0.9648592
    
    Calculating for Black-naped oriole
    Mean Density: 1.476958
    Std err. of Mean Density: 0.2464279
    Lower CI: 0.9910127
    Upper CI: 1.962903
    %CV: 235.9591%
    Total Individuals: 2.215437
    Std err. of Total Individuals: 0.3696419
:Graphs: None

Finding Total Observations per Species
--------------------------------------

:File:
  `03-basic_aggregates.r
  <03-basic_aggregates.r>`_
:Type: Rscript
:Output:
  ::
    
    All valid observations: 1127
    Locations with all valid observations: 179
    Javan myna observations: 408
    Yellow-vented bulbul observations: 269
    Olive-backed sunbird  observations: 167
    Rock pigeon observations: 85
    Black-naped oriole observations: 58
    Total observations: 987
    Locations with observations of selected species: 173
:Graphs:
  .. image:: 03-basic_aggregates.png

Comparing Observations Across Groups
------------------------------------

:File:
  `04-group_counts.r
  <04-group_counts.r>`_
:Type: Rscript
:Output:
  ::
  
                Group.Name Observations
    1         Ashy Minivet           82
    2           Asian Koel           89
    3   Banded Woodpecker            78
    4        Brahminy Kite          125
    5  Collared Kingfisher           85
    6   Coppersmith Barbet          171
    7      Crimson Sunbird           97
    8      Pacific Swallow           87
    9         Spotted Dove          100
    10    Spotted Wood Owl           73
    Total: 987
    s = 29.26906 and mean = 98.7
    Coefficient of Variation = 29.655%
:Graphs:
  .. image:: 04-group_counts.png

Comparing Observations Across time Periods
------------------------------------------

:File:
  `05-obs_per_timeperiod.r
  <05-obs_per_timeperiod.r>`_
:Type: Rscript
:Output: None
:Graphs:
  .. image:: 05-obs_per_timeperiod.png

Comparing Observations per Survey Across Time Periods
-----------------------------------------------------

:File:
  `06-obs_per_survey_per_timeperiod.r
  <06-obs_per_survey_per_timeperiod.r>`_
:Type: Rscript
:Output:
  ::
  
    $names
     [1] "coefficients"  "residuals"     "effects"       "rank"         
     [5] "fitted.values" "assign"        "qr"            "df.residual"  
     [9] "xlevels"       "call"          "terms"         "model"        
    
    $class
    [1] "lm"
    
    [1] 173
:Graphs:
  .. image:: 06-obs_per_survey_per_timeperiod.png

Comparing Observations per Distance Bin
---------------------------------------

:File:
  `07-bird_per_distance.r
  <07-bird_per_distance.r>`_
:Type: Rscript
:Output: None
:Graphs:
  .. image:: 07-bird_per_distance_general.png
  .. image:: 07-bird_per_distance_Javan%20myna.png
  .. image:: 07-bird_per_distance_Yellow-vented%20bulbul.png
  .. image:: 07-bird_per_distance_Olive-backed%20sunbird.png
  .. image:: 07-bird_per_distance_Rock%20pigeon.png
  .. image:: 07-bird_per_distance_Black-naped%20oriole.png
