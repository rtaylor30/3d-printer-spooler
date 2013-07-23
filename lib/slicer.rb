require 'open3'

class Slicer
  class << self
    def run_slicer print_request_id
      print_request = PrintRequest.find print_request_id
      cmd = "slic3r --load #{Rails.root.join 'config', 'slicer_config.ini'} #{Rails.root.join 'public', 'stl_files', print_request.stl_file_name}"
      Open3.popen3( cmd ) { |stdin, stdout, stderr, wait_thr|
        if wait_thr.value != 0
          print_request.status = 'Error Parsing STL File'
        else
          print_request.status = 'Not Ready'
        end

        print_request.gcode_filename = print_request.stl_file_name[0..-4] + 'gcode'
        print_request.save
      }
    end
    handle_asynchronously :run_slicer
  end
end

