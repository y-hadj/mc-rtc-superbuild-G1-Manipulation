set(EXTENSIONS_DIR ${CMAKE_CURRENT_LIST_DIR}/superbuild-extensions)
include(${EXTENSIONS_DIR}/gui/mc_rtc-magnum.cmake)
include(${EXTENSIONS_DIR}/interfaces/mc_mujoco.cmake)

AddProject(
    mc_manipulation_objects
    GITHUB Noceo200/mc_manipulation_objects
    GIT_TAG origin/main
  )
  
if(WITH_G1)
  AddProject(
    g1_mj_description
    GITHUB y-hadj/g1_mj_description
    GIT_TAG main
    DEPENDS mc_mujoco
  )
  
  AddProject(unitree_sdk2
    GITHUB y-hadj/unitree_sdk2
    GIT_TAG main
  )

  AddProject(mc_unitree2
    GITHUB y-hadj/mc_unitree2_wG1
    GIT_TAG master
    DEPENDS mc_rtc unitree_sdk2
    CMAKE_ARGS -DGENERATE_G1_REVO2_CONTROLLER=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5
  )

  AddProject(mc_external_forces_observer
    GITHUB y-hadj/mc_external_forces_observer
    GIT_TAG main
    DEPENDS mc_rtc
  )

  AddProject(mc_joystick_plugin
    GITHUB isri-aist/mc_joystick_plugin
    GIT_TAG origin/main
    DEPENDS mc_rtc
  )

  AddProject(FootSteps_Planner
    GITHUB isri-aist/FootSteps_Planner
    GIT_TAG origin/main
    DEPENDS mc_rtc
  )

  AddProject(pendulum_feasibility_solver
    GITHUB isri-aist/pendulum_feasibility_solver
    GIT_TAG origin/master
    DEPENDS SpaceVecAlg eigen-quadprog
  )

  AddProject(ismpc_walking
    GITHUB y-hadj/ismpc_walking
    GIT_TAG main
    DEPENDS mc_rtc pendulum_feasibility_solver mc_joystick_plugin FootSteps_Planner
  )
endif()

if(WITH_Revo2)
  AddProject(
    revo2_mj_description
    GITHUB isri-aist/revo2_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco
  )
endif()

if(WITH_Honda)
  AddProject(
    honda_mj_description
    GITE onoel/honda_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco
  )
endif()

