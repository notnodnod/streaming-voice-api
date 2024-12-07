def foo(bar: str) -> str:
    """Summary line.

    Extended description of function.

    Args:
        bar: Description of input argument.

    Returns:
        Description of return value
    """

    return bar


if __name__ == "__main__":
    import logging

    from RealtimeTTS import CoquiEngine, TextToAudioStream

    def dummy_generator():
        yield "Hey guys! These here are realtime spoken sentences based on local text synthesis. "
        yield "With a local, neuronal, cloned voice. So every spoken sentence sounds unique."

    level = logging.DEBUG
    debug = True

    print("Starting the test script")

    source_voice = "voices/female_01.wav"
    coqui_engine = CoquiEngine(voice=source_voice, level=level)
    stream = TextToAudioStream(coqui_engine, level=level)
    stream.feed(dummy_generator())
    stream.play(output_wavfile="outputs/" + stream.engine.engine_name + "_output.wav", debug=debug)
    coqui_engine.shutdown()
