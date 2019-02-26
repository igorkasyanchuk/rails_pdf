# RailsPDF

Create PDF documents in Rails your app from HTML, CSS and JS.

**Features:**

- Basically, you can create any HTML/CSS/JS/Images page and save into PDF
- Generate PDF on the fly or save to disk
- With header, footer, page numbers, layout support
- Has few starter templates to help with most popular reports. Just create some and re-edit it
- Support for Charts libraries
- ERB/SCSS support
- Custome & Google fonts
- Separates PDF templates from app views
- Doesn't insert any middleware into your app
- Pub format is similar to slim

It's uses [ReLaXedJS](https://github.com/RelaxedJS/ReLaXed) tool, which is wrapper arround chromium headless.

The idea of this gem is to separate logic of PDF creation from regular Rails views/controllers. Make it independent and easy to maintain.

## Template starters

_If you want to contribute and add more templates - it' very easy to do. See #Templates section of this doc._

<table>
  <tr align="center">
    <td width="25%">
      <a href="https://github.com/igorkasyanchuk/rails_pdf/blob/master/docs/report_1.png">
        <img src="https://github.com/igorkasyanchuk/rails_pdf/blob/master/docs/report_1_thumb.png?raw=true" />
      </a>      
      Template: <a href="https://github.com/igorkasyanchuk/rails_pdf/blob/master/lib/generators/rails_pdf/templates/simple_invoice/invoice.pug.erb">simple_invoice</a>
    </td>
    <td width="25%">
      <a href="https://github.com/igorkasyanchuk/rails_pdf/blob/master/docs/report_2.png">
        <img src="https://github.com/igorkasyanchuk/rails_pdf/blob/master/docs/report_2_thumb.png?raw=true" />
      </a>      
      Template: <a href="https://github.com/igorkasyanchuk/rails_pdf/blob/master/lib/generators/rails_pdf/templates/basic_invoice/invoice.pug.erb">basic_invoice</a>
    </td>
    <td width="50%">
      <a href="https://github.com/igorkasyanchuk/rails_pdf/blob/master/docs/report_3c.png">
        <img src="https://github.com/igorkasyanchuk/rails_pdf/blob/master/docs/report_3c_thumb.png?raw=true" />
      </a>      
      Template: <a href="https://github.com/igorkasyanchuk/rails_pdf/blob/master/lib/generators/rails_pdf/templates/chart1/chart.pug.erb">chart1</a>
    </td>
  </tr>
</table>

## Usage

You can use predefined starter templates (and you are welcome to contribute and create additional templates):

Use template starters:

- `rails g rails_pdf new invoice_report` (create blank template for PDF)
- `rails g rails_pdf basic_invoice report`
- `rails g rails_pdf chart1 report`
- `rails g rails_pdf simple_invoice report`

After you've generated PDF template, you can edit it in `app/pdf/<folder>/<file>` file.

You can use JS/CSS files from `app/pdf/shared` (which includes bootstrap 4, foundation 6, Found Awesome 5, Charts.js).

This is how you can generate and send PDF files on the fly:

```ruby
  def report
    RailsPDF.template("report2/invoice.pug.erb").render do |data|
      send_data(data, type: 'application/pdf', disposition: 'inline', filename: 'report.pdf')
    end
  end
  
  # or return file as attachment
  
  def invoice
    RailsPDF.template("report2/invoice.pug.erb").render do |data|
      send_data(data, type: 'application/pdf', disposition: 'attachment', filename: 'report.pdf')
    end
  end  
```

If you need to create PDF file and save to file on drive:

```ruby
RailsPDF.template("report/chart.pug.erb").render_to_file('path/docs/report.pdf') # File

# or for html template

RailsPDF.template("sales/invoice.html.erb").render_to_file('path/docs/report.pdf') # File
```

Same but save PDF into Temfile:

```ruby
RailsPDF.template("report/chart.pug.erb").render_to_tempfile('report.pdf') # Tempfile
```

With ERB files you can use App code (like models, etc). For example you can iterate over @users and output in PDF.

JS/CSS/Images/

```slim
style
  include:scss <%= Rails.root %>/app/pdf/report/stylesheets/invoice.scss

img(src="<%= Rails.root %>/app/pdf/shared/images/rails_pdf.png")

script(src='<%= Rails.root %>/app/pdf/shared/javascripts/Chart.bundle.min.js')
```


## Installation

Installation of gem is very simple, it's just requires one additional step to install RelaxedJS tool which is using Chrome headless.

### Requirements

- RelaxedJS 0.2.0+ (check with `relaxed --version`)
- Chrome headless (bundled with relaxedjs)
- Rails 5+ app

#### Install RelaxedJS

>git clone https://github.com/RelaxedJS/ReLaXed.git .
>npm install
>sudo npm link --unsafe-perm=true

Verify it's installed with: `relaxed --version`.

#### Gemfile

```ruby
gem 'rails_pdf'
```

And then execute:
```bash
$ bundle
```

## Templates

## Tips

- if you want to add a page-break in document: `div(style="page-break-before:always")`
- if you are using bootstrap and you want to use columns - include bootstrap.print.css and use styles from it.
- if you are using Charts.js and you want to clear and readable text put in options: `devicePixelRatio: 3,`
- you can define size of page using in SCSS:
```
  // A4
  $page-width: 8.27in;
  $page-height: 11.69in;
```  
- if you want to add header/footer (sample: lib/generators/rails_pdf/templates/simple_invoice/invoice.pug.erb)
```
  h1 My document
  p some paragraph

  template#page-header
    p I appear at the top of the page

  template#page-footer
    p I appear at the bottom of the page
```
- if you see an error, or something is not generated check TMP folder (e.g. /tmp) tmp/*.html file (see most recent files).
- if you have problems with Charts.js you can add setTimeout(...) and execute chart creation in 200-300ms.

## Development

- open `test/dummy`
- rake db:migrate
- `rails s -b 0.0.0.0`
- open `localhost:3000/report.pdf`
- modify templates in app/pdf

## Adding a new template

- add new template in `lib/generators/rails_pdf/templates` and add folder with template (html,css,js)
- you can use CSS/JS from `templates/shared` folder
- edit `lib/generators/rails_pdf/rails_pdf_generator.rb` add new type of report
- create screenshot of template and put in `docs` folder
- update docs
- create PR

## TODO

- more starter templates
  - add starter template with page numbers
- add different charts
- better way to include JS/CSS/images
- maybe we don't need to include all views
- support non-rails apps
- specs
- travis CI
- codeclimate
- check support for older Rails (should work but check is needed)
- check embedding in emails
- maybe add ability to save webpage by url or HTML snippet to PDF, e.g. `RailsPDF.url("http://google.com").render_to_file("google.com.pdf")`
- better gem logo :)

## Production

Before deploy app to production please don't forget to install Relaxed.JS on it.

## Contributing

You are welcome to contribute.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
