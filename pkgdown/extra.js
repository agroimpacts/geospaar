/* Keep pkgdown article headings and their sidebar TOC numbered identically. */
(function ($) {
  $(function () {
    var main = $(".template-article #main");
    var toc = $(".template-article #toc");
    if (!main.length || !toc.length || main.data("numbered-toc")) {
      return;
    }

    var headings = main.find("h2, h3, h4, h5, h6").filter(function () {
      return !this.hasAttribute("data-toc-skip");
    });
    if (!headings.length) {
      return;
    }

    var counters = [0, 0, 0, 0, 0];
    var entries = [];

    headings.each(function () {
      var heading = $(this);
      var level = Number(this.tagName.substring(1)) - 2;

      counters[level] += 1;
      for (var index = level + 1; index < counters.length; index += 1) {
        counters[index] = 0;
      }

      var number = counters.slice(0, level + 1).join(".");
      var text = heading.clone().children(".anchor, .section-number").remove().end().text().trim();
      heading.prepend($("<span>", {
        "class": "section-number",
        text: number + "."
      }));
      entries.push({ id: this.id, level: level, number: number, text: text });
    });

    toc.children("ul").remove();
    var root = $("<ul>", { "class": "nav navbar-nav" });
    toc.append(root);
    var lists = [root];

    entries.forEach(function (entry) {
      while (lists.length > entry.level + 1) {
        lists.pop();
      }
      while (lists.length < entry.level + 1) {
        var parent = lists[lists.length - 1].children("li").last();
        if (!parent.length) {
          break;
        }
        var child = $("<ul>", { "class": "nav navbar-nav" });
        parent.append(child);
        lists.push(child);
      }

      var link = $("<a>", {
        "class": "nav-link",
        href: "#" + entry.id,
        text: entry.number + ". " + entry.text
      });
      lists[lists.length - 1].append($("<li>").append(link));
    });

    toc.find("li").each(function () {
      var item = $(this);
      if (!item.children("ul.nav").length) {
        return;
      }
      item.addClass("toc-parent");
      item.prepend($("<button>", {
        "aria-expanded": "false",
        "aria-label": "Show subsections for " + item.children("a").text(),
        "class": "toc-toggle",
        type: "button"
      }));
    });

    function openBranch(item) {
      var branch = item.parents("li").addBack();
      branch.each(function () {
        $(this).siblings("li").removeClass("toc-open").children(".toc-toggle")
          .attr("aria-expanded", "false");
      });
      branch.addClass("toc-open").children(".toc-toggle").attr("aria-expanded", "true");
    }

    toc.on("click", ".toc-toggle", function () {
      var item = $(this).parent("li");
      if (item.hasClass("toc-open")) {
        item.removeClass("toc-open");
        $(this).attr("aria-expanded", "false");
      } else {
        openBranch(item);
      }
    });

    main.data("numbered-toc", true);
  });
})(window.jQuery || window.$);
