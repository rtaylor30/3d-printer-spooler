require 'open3'

class Slicer
  def run_slicer stl_file_name
    cmd = "slic3r --load ~/Slic3r/3mm_pt5-nzl_pt3-lyr.ini #{stl_file_name}"
    Open3.popen3 cmd { |stdin, stdout, stderr, wait_thr|
      # TODO : Do something when the slicer application doesn't run as expected
    }
  end
end

