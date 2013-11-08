from .common import *


class TestVideoFrameBasics(TestCase):

    def test_null_constructor(self):
        frame = VideoFrame()
        self.assertEqual(frame.width, 0)
        self.assertEqual(frame.height, 0)
        self.assertEqual(frame.format.name, 'yuv420p')

    def test_manual_yuv_constructor(self):
        frame = VideoFrame(640, 480, 'yuv420p')
        self.assertEqual(frame.width, 640)
        self.assertEqual(frame.height, 480)
        self.assertEqual(frame.format.name, 'yuv420p')

    def test_manual_rgb_constructor(self):
        frame = VideoFrame(640, 480, 'rgb24')
        self.assertEqual(frame.width, 640)
        self.assertEqual(frame.height, 480)
        self.assertEqual(frame.format.name, 'rgb24')

    def xtest_buffer(self):
        frame = VideoFrame(640, 480, 'rgb24')
        frame.update_from_string('01234' + ('x' * (640 * 480 * 3 - 5)))
        buf = buffer(frame)
        self.assertEqual(buf[1], b'1')
        self.assertEqual(buf[:7], b'01234xx')


    def xtest_memoryview_read(self):
        try:
            memoryview
        except NameError:
            raise SkipTest()
        frame = VideoFrame(640, 480, 'rgb24')
        frame.update_from_string('01234' + ('x' * (640 * 480 * 3 - 5)))
        mem = memoryview(frame)
        self.assertEqual(mem.ndim, 1)
        self.assertEqual(mem.shape, (640 * 480 * 3, ))
        self.assertFalse(mem.readonly)
        self.assertEqual(mem[1], b'1')
        self.assertEqual(mem[:7], b'01234xx')
        mem[1] = '.'
        self.assertEqual(mem[:7], b'0.234xx')


class TestVideoFrameTransforms(TestCase):

    def setUp(self):
        self.lenna = Image.open(asset('lenna.png'))
        self.width, self.height = self.lenna.size

    def xtest_lena_roundtrip(self):
        frame = VideoFrame(self.width, self.height, 'rgb24')
        frame.update_from_string(self.lenna.tostring())
        img = frame.to_image()
        img.save(self.sandboxed('lenna-roundtrip.jpg'))
        self.assertImagesAlmostEqual(self.lenna, img)


class TestVideoFramePlanes(TestCase):

    def test_null_planes(self):
        frame = VideoFrame() # yuv420p
        self.assertEqual(len(frame.planes), 0)

    def test_yuv420p_planes(self):
        frame = VideoFrame(640, 480, 'yuv420p')
        self.assertEqual(len(frame.planes), 3)
        self.assertEqual(frame.planes[0].width, 640)
        self.assertEqual(frame.planes[0].height, 480)
        self.assertEqual(frame.planes[0].line_size, 640)
        self.assertEqual(frame.planes[0].buffer_size, 640 * 480)
        for i in xrange(1, 3):
            self.assertEqual(frame.planes[i].width, 320)
            self.assertEqual(frame.planes[i].height, 240)
            self.assertEqual(frame.planes[i].line_size, 320)
            self.assertEqual(frame.planes[i].buffer_size, 320 * 240)

    def test_rgb24_planes(self):
        frame = VideoFrame(640, 480, 'rgb24')
        self.assertEqual(len(frame.planes), 1)
        self.assertEqual(frame.planes[0].width, 640)
        self.assertEqual(frame.planes[0].height, 480)
        self.assertEqual(frame.planes[0].line_size, 640 * 3)
        self.assertEqual(frame.planes[0].buffer_size, 640 * 480 * 3)