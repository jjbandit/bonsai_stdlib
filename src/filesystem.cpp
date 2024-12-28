link_internal b32
SearchForProjectRoot(void)
{
#if BONSAI_EMCC
  b32 Result = True;
#else
  b32 Result = FileExists(".root_marker");

  b32 ChdirSuceeded = True;
  b32 NotAtFilesystemRoot = True;

  /* ChdirSuceeded = (_chdir("/home/scallywag/bonsai") == 0); */
  while (!Result && ChdirSuceeded && NotAtFilesystemRoot)
  {
    ChdirSuceeded = PlatformChangeDirectory("..");
    NotAtFilesystemRoot = (!IsFilesystemRoot(GetCwd()));
    Result = FileExists(".root_marker");
  }
#endif
  return Result;
}
