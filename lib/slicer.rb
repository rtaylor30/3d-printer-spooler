require 'open3'

class Slicer
  class << self
    def run_slicer print_request_id
      print_request = PrintRequest.find print_request_id
      cmd = "slic3r --load ~/Slic3r/3mm_pt5-nzl_pt3-lyr.ini #{print_request.stl_file_name}"
      Open3.popen3 cmd { |stdin, stdout, stderr, wait_thr|
        # TODO : Do something when the slicer application doesn't run as expected
      }
    end
    handle_asynchronously :run_slicer
  end
end

