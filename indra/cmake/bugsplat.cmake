# BugSplat is engaged by setting BUGSPLAT_DB to the target BugSplat database
# name.
if (BUGSPLAT_DB)
  if (USESYSTEMLIBS)
    message(STATUS "Looking for system BugSplat")
    set(BUGSPLAT_FIND_QUIETLY ON)
    set(BUGSPLAT_FIND_REQUIRED ON)
    include(FindBUGSPLAT)
  else (USESYSTEMLIBS)
    message(STATUS "Engaging autobuild BugSplat")
    include(Prebuilt)
    use_prebuilt_binary(bugsplat)
    if (WINDOWS)
      set(BUGSPLAT_LIBRARIES 
        ${ARCH_PREBUILT_DIRS_RELEASE}/bugsplat.lib
        )
    elseif (DARWIN)
      find_library(BUGSPLAT_LIBRARIES BugsplatMac
        PATHS "${ARCH_PREBUILT_DIRS_RELEASE}")
      message(FATAL_ERROR "Bugsplat for OSX not fully implemented, please adapt llappdelegate-objc.mm to honor options of sending user name and settings.xml.")
    else (WINDOWS)
      message(FATAL_ERROR "Bugsplat for Linux not implemented.")

    endif (WINDOWS)
    set(BUGSPLAT_INCLUDE_DIR ${LIBS_PREBUILT_DIR}/include/bugsplat)
  endif (USESYSTEMLIBS)
endif (BUGSPLAT_DB)
